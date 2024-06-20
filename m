Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C11BA07C
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906237; cv=none; b=QAOsph/DggqG8XpI06i+d2rf19ALTlx8+c10Tk8d2DZUwnXJvvVqrU2b7YyFNpN9UJ2y/fC+OhPvDxZuD8tQC9ub33iFWgyTT6HwtYwiEn8lPOagnCm9Htr1GiOEjbFrNjqPuQv5YWa9ZsmJqLNAv2VGbpDwd0ad2G6lCvF3lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906237; c=relaxed/simple;
	bh=AaGeTjrw0FfF+0h9/U20FA8dwnbicgFR6M2oz4CBhwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saYHHK/gETN5oulQHjzRo+QjFppqP/bhScEzFupoMpZXpjHlXC676vdwyHmVjGxpJtgOjtsy8M5LZuXp3wFO0OIw7BhSZX8I21rTvoTi/kcy32AijbckXhOYSWUctodNyeFkLKGwzb8GtGvvKtuFYwH4KR6+YcKnSlogJlfwvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVw+2/bJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVw+2/bJ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e9f52e99c2so868523a12.1
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906235; x=1719511035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93DcC67mVeY/+nPj/RabbHCmpdvAxDoR+WvyjbP4Fv8=;
        b=jVw+2/bJt3WILMssTyKJWypUapRPaYLLW2nerS/vWY5gX83AZB7ZWcPhC7VHLgDcTy
         lqe3oiLW1CTjMYEESOzPTO7Nn+UggTQ4rYm4E86gt2QN/scGmcnR1OcesOnDRsizKWAU
         5wPRZ2wpQyvXHw3AqeFoyd937AYRrtXMOAdw8mLMLSrOzjX5TwGSn960gl0KZJ9A3hDZ
         +nXtM+1xUB+x3tPJEvQDJP3QE8JMrr6hk/QjCx7jjqybVr+bfXeFyIh8Ay7NIMb6JtFg
         eAKHk7CbvasHB9gNhmHPZ0CdQpRaklH9s88pgypqE1OC1BRNfbjFJuZmLeWhpyOT6Cvy
         Q7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906235; x=1719511035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93DcC67mVeY/+nPj/RabbHCmpdvAxDoR+WvyjbP4Fv8=;
        b=XGwzrWY/atTyBHpcnv+oLMnOgSut7nURJJXADnMKgcoZxDBFySHZ6KRWYjX/5LnWIr
         GnauRyRSDyImi7qDqwbg+RHsCWviDWFpPr/iAxOu3bMDg8Z4J20ZKSepJHDLfO6Rz8zm
         tHGePbAOzHIh2C4ecAxl/danjaX/90uACnZ9oUEUHUQSw6oDWIO+pMK9MxL8z0TlFhQG
         /guv7A+sAI4krrydIqV6hEDJEMgWk4ONYrKKfohzP4DzlEIr8kVsjbT3yjEXOt4XR1vz
         1FykoTzYSgqW8rscKYl6XzwOh4jX7JaHUR+eW1FckKPFJNbHwlA6zeZFpQveFxRpv4fT
         uktw==
X-Forwarded-Encrypted: i=1; AJvYcCWYjGNSySlLwdsSVT4dFMRCDujxpqGeCcMTzmQfDxliGRiKIcVvvyIsDyew72MJ3Fb/khyLw/A40Vq13WXDy+IFyaXA5ro=
X-Gm-Message-State: AOJu0Yw1ET7Oy6+RIzdcHI0jl8PUgo0XGXH0FGiLCt0CtHITIDEQuzrZ
	iNtqLg3tUihawQiMZhW+MPdTRq7Gyv4vwYexdINT+4g5hDdK8u8E
X-Google-Smtp-Source: AGHT+IF9ITZbJ7vVNEYTX8RCffN7BEtSM9imchEPcbZOZxImDJdvzQARxKbAqm1aXg+Hi0vjNW3ABQ==
X-Received: by 2002:a17:902:f687:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1f9aa3ecca8mr64371665ad.12.1718906234591;
        Thu, 20 Jun 2024 10:57:14 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d28ce155sm15196715ad.259.2024.06.20.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:14 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Rich Felker <dalias@libc.org>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	GR-QLogic-Storage-Upstream@marvell.com,
	alsa-devel@alsa-project.org,
	ath10k@lists.infradead.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 02/40] lib/find: add test for atomic find_bit() ops
Date: Thu, 20 Jun 2024 10:56:25 -0700
Message-ID: <20240620175703.605111-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic functionality test for new API.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65a75d58ed9e..405f79dd2266 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/find_atomic.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -221,6 +222,65 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
+static void __init test_find_and_bit(void)
+{
+	unsigned long w, w_part, bit, cnt = 0;
+	DECLARE_BITMAP(bmap, EXP1_IN_BITS);
+
+	/*
+	 * Test find_and_clear{_next}_bit() and corresponding
+	 * iterators
+	 */
+	bitmap_copy(bmap, exp1, EXP1_IN_BITS);
+	w = bitmap_weight(bmap, EXP1_IN_BITS);
+
+	for_each_test_and_clear_bit(bit, bmap, EXP1_IN_BITS)
+		cnt++;
+
+	expect_eq_uint(w, cnt);
+	expect_eq_uint(0, bitmap_weight(bmap, EXP1_IN_BITS));
+
+	bitmap_copy(bmap, exp1, EXP1_IN_BITS);
+	w = bitmap_weight(bmap, EXP1_IN_BITS);
+	w_part = bitmap_weight(bmap, EXP1_IN_BITS / 3);
+
+	cnt = 0;
+	bit = EXP1_IN_BITS / 3;
+	for_each_test_and_clear_bit_from(bit, bmap, EXP1_IN_BITS)
+		cnt++;
+
+	expect_eq_uint(bitmap_weight(bmap, EXP1_IN_BITS), bitmap_weight(bmap, EXP1_IN_BITS / 3));
+	expect_eq_uint(w_part, bitmap_weight(bmap, EXP1_IN_BITS));
+	expect_eq_uint(w - w_part, cnt);
+
+	/*
+	 * Test find_and_set{_next}_bit() and corresponding
+	 * iterators
+	 */
+	bitmap_copy(bmap, exp1, EXP1_IN_BITS);
+	w = bitmap_weight(bmap, EXP1_IN_BITS);
+	cnt = 0;
+
+	for_each_test_and_set_bit(bit, bmap, EXP1_IN_BITS)
+		cnt++;
+
+	expect_eq_uint(EXP1_IN_BITS - w, cnt);
+	expect_eq_uint(EXP1_IN_BITS, bitmap_weight(bmap, EXP1_IN_BITS));
+
+	bitmap_copy(bmap, exp1, EXP1_IN_BITS);
+	w = bitmap_weight(bmap, EXP1_IN_BITS);
+	w_part = bitmap_weight(bmap, EXP1_IN_BITS / 3);
+	cnt = 0;
+
+	bit = EXP1_IN_BITS / 3;
+	for_each_test_and_set_bit_from(bit, bmap, EXP1_IN_BITS)
+		cnt++;
+
+	expect_eq_uint(EXP1_IN_BITS - bitmap_weight(bmap, EXP1_IN_BITS),
+			EXP1_IN_BITS / 3 - bitmap_weight(bmap, EXP1_IN_BITS / 3));
+	expect_eq_uint(EXP1_IN_BITS * 2 / 3 - (w - w_part), cnt);
+}
+
 static void __init test_find_nth_bit(void)
 {
 	unsigned long b, bit, cnt = 0;
@@ -1482,6 +1542,8 @@ static void __init selftest(void)
 	test_for_each_clear_bitrange_from();
 	test_for_each_set_clump8();
 	test_for_each_set_bit_wrap();
+
+	test_find_and_bit();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.43.0

