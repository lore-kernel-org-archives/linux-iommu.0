Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEA38DF9
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439775; cv=none; b=BsWQf1XnqXWMME7etetFQAmSJg2KQa/57JZIWojbMfcIywfBBTe2TBD6OjbZmd85yl4XHzuMFizeyBpjlbrHUjA0UKFFcImyfR3GJvRxvH92qcqOVbHRG4lbldqz8zy30MkejkYUrp6nXf/jVmKV32LpIa7wQZVfIbwIlL+JJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439775; c=relaxed/simple;
	bh=1vRkzvTTeVF6TFOKiD6ZTs+gv9kiEolkiBirj5g/cLo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKJ6fl4AfqsIPZju23Cne3SlOJmBm/lWyuoU6tIFMDIA8DOsoAy7QTPJR8KbfV9Z4eG/b9iheP9XYPPgJPhOMteetodE6RiHyNDTEZt+24MlLFn8dWAD2gZ/aI6q5EZ3SUgur2zH0n6RPWJNbrStVny+M1LZYIppn0VOQCW7ZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vkO77-0000bW-Po 
	for iommu@lists.linux.dev; Mon, 26 Jan 2026 16:02:49 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vkO6y-0000000054O-2DRS
	for iommu@lists.linux.dev;
	Mon, 26 Jan 2026 16:02:40 +0100
Date: Mon, 26 Jan 2026 16:02:40 +0100
From: Johannes Stezenbach <js@sig21.net>
To: iommu@lists.linux.dev
Subject: Asrock X600 port80 UART
Message-ID: <aXeCECwwtHhhzedL@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeAOtGQUdlNZF6V@sig21.net>

(I post this here for lack of a better place. Hope interested
persons can find it.)

The Asrock Deskmini X600 has a "UART1" connector (search for
"molex picoblade 1.25mm 4-pin cable" to find matching cables).
See https://www.asrock.com/mb/photo/X600M-STX%20R2.0(L2).png at
the bottom between the two SATA connectors.

Pin 1	GND
Pin 2	?
Pin 3	TX	+3.3V
Pin 4	+5V

The X600 has an nct6686d SuperIO chip which has a "PORT80 UART"
function to forward ioport 80 debug writes to the UART interface.
Apparently it is connected to the "UART1" connector, and I dumped
some of the nct6686d configuration registers to confirm the
port80 UART is enabled by strap settings with 115200 8N1
(actual speed is 2MHz / 17).

https://www.nuvoton.com/resource-files/NCT6686D_HW_Datasheet_V0_5.pdf

Connecting a 3.3V compatible USB-serial cable confirms there is
some binary output from firmware debug during boot. I wrote a
simple console driver to write kernel messages via port80 to
get output during suspend/resume/hibernate, it works well enough
with some binary output from firmware interspersed.

Use it with kernel command line options:

console=port80 console=tty0 no_console_suspend keep_bootcon debug

I think this patch is too much of a hack for inclusion in
the kernel, but here it is for anyone who wants it.

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c883a28e0916..e09a8e987638 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1037,6 +1037,12 @@ config OXP_EC
 
 source "drivers/platform/x86/tuxedo/Kconfig"
 
+config PORT80_CONSOLE
+	tristate "PC debug ioport 80 console"
+	help
+	  use PC debug ioport 80 as console output via port80-UART
+	  supported by some Nuvoton SuperIO chips like NCT6686D
+
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c7db2a88c11a..4e92ae18415d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -163,3 +163,5 @@ obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
 
 # OneXPlayer
 obj-$(CONFIG_OXP_EC)			+= oxpec.o
+
+obj-$(CONFIG_PORT80_CONSOLE)		+= port80_cons.o
diff --git a/drivers/platform/x86/port80_cons.c b/drivers/platform/x86/port80_cons.c
new file mode 100644
index 000000000000..cfe71dd5a760
--- /dev/null
+++ b/drivers/platform/x86/port80_cons.c
@@ -0,0 +1,68 @@
+/* use PC debug ioport 80 as console output via port80-UART
+ * supported by some Nuvoton SuperIO chips like NCT6686D
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+
+
+static uint delay = 200;
+module_param(delay, uint, 0644);
+MODULE_PARM_DESC(delay, "per charater output delay in us (default 200)");
+
+
+static void p80_putchar(u8 ch)
+{
+	if (ch == '\n') {
+		outb_p('\r', 0x80);
+		udelay(delay);
+	}
+	outb_p(ch, 0x80);
+	udelay(delay);
+}
+
+static void p80_write(struct console *con, const char *s, unsigned n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++, s++)
+		p80_putchar(*s);
+}
+
+static int __init p80_early_console_setup(struct earlycon_device *device,
+					     const char *opt)
+{
+	device->con->write = p80_write;
+	return 0;
+}
+
+EARLYCON_DECLARE(port80, p80_early_console_setup);
+
+
+static struct console p80cons = {
+	.name		= "port80",
+	.write		= p80_write,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+};
+
+static int __init p80_init(void)
+{
+	register_console(&p80cons);
+	printk("registered port80 console\n");
+	return 0;
+}
+
+static void p80_exit(void)
+{
+	unregister_console(&p80cons);
+}
+
+module_init(p80_init);
+module_exit(p80_exit);
+
+MODULE_DESCRIPTION("Port80 console driver");
+MODULE_LICENSE("GPL v2");
