Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F8DC2BD09
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 02:43:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FE5206E0
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 02:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwUf65Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FE5206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 466EC2039D;
	Tue, 10 Dec 2019 02:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eX8M2E28ABO5; Tue, 10 Dec 2019 02:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 304412038B;
	Tue, 10 Dec 2019 02:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E525C1796;
	Tue, 10 Dec 2019 02:43:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DCD9C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 22EDB87196
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpIOTrRhDD40 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 02:43:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2114586919
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:43:21 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id 2so8250373pfx.6
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+pVRv0zmwM6r6qh3u7jefx+roN9IpRfJikQs29Fs7Mc=;
 b=uwUf65DtxepoaHGo4O1l3eRw7LX0FXVzucUtAwwuLkcVjQsqdGxJD9cMJLM3nuxt4J
 etcJjflqicP0aEqaF9T0mrVMdUzRjrsOc2W9D1SN+k2VoeOlPGsRtdsv0sKEtSjUCyX7
 lbr3bTGxNh6VVe6bsLgKqdVUaqgeK2IH7WEp13jtZayc88doNqd1tyqwQn9FF71k1g8f
 ds1XNZVb96EMb7mSGq4cYsAA40g3HW9oHxI72pOcoR2X4xireKpY1GkZ4zSW/b0XF39r
 BLvCXgssR3l9lvlzi7vtpOoVHsaTGYXgbOfozM7Bh4NRkEbPnNPue9YdVQZq/PH6l+9Q
 O0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+pVRv0zmwM6r6qh3u7jefx+roN9IpRfJikQs29Fs7Mc=;
 b=NL1a89A92crjVyp+MzOOIAjKUerhymKRGkkId5yyJoE11n0ioQ21znj9qSEdxBVgJD
 IW0XNj2c5r2zWgKL5w2SpvJOQPpMiwFjqs/2Ldr0kuYNVFNl32bKGcLLPPbv+TGC2kP/
 7BDLeKeqvhiAGrofM/PKGQJ9HsrIGZb+Di47TQZLDoe2ytH/dr21amNKNALq7zGWL32z
 2a6FvEtomUyoDRGSv080DA6lOPpXCSntbGp7Wp6T+ErFQUVWS3qTD4gpRfd3t5jIFdlj
 IZe1yKoBF8m3NGKaFeRC9SMjzEKHo6Lx4/Pu60OkoBnLvz+fKpYcUOKnLHV/pcSOKw4D
 rg9w==
X-Gm-Message-State: APjAAAXr2iwFHLfA5RoRsHiwchuhk/Mc54z8dO+M/peV3tYTcz8fWSXo
 FceL9NMH3wcXBnVpwT+peq92wA==
X-Google-Smtp-Source: APXvYqzMKJNjBhRBPDcrkkes2iin/sH2CGOoYy8Yji3QEs2l5nJTTLxLWlg03FQisfLHcm0v16ysHw==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr34122975pfh.182.1575945800496; 
 Mon, 09 Dec 2019 18:43:20 -0800 (PST)
Received: from localhost.localdomain ([240e:362:417:e00:ed89:9d55:8cd5:6d38])
 by smtp.gmail.com with ESMTPSA id
 r6sm826422pfh.91.2019.12.09.18.43.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 09 Dec 2019 18:43:20 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [RESEND PATCH v9 1/4] uacce: Add documents for uacce
Date: Tue, 10 Dec 2019 10:42:32 +0800
Message-Id: <1575945755-27380-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
References: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Kenneth Lee <liguozhu@hisilicon.com>, linux-accelerators@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) is
a kernel module targets to provide Shared Virtual Addressing (SVA)
between the accelerator and process.

This patch add document to explain how it works.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/misc-devices/uacce.rst | 176 +++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..1db412e
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of Uacce
+---------------------
+
+Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
+provide Shared Virtual Addressing (SVA) between accelerators and processes.
+So accelerator can access any data structure of the main cpu.
+This differs from the data sharing between cpu and io device, which share
+only data content rather than address.
+Because of the unified address, hardware and user space of process can
+share the same virtual address in the communication.
+Uacce takes the hardware accelerator as a heterogeneous processor, while
+IOMMU share the same CPU page tables and as a result the same translation
+from va to pa.
+
+::
+
+         __________________________       __________________________
+        |                          |     |                          |
+        |  User application (CPU)  |     |   Hardware Accelerator   |
+        |__________________________|     |__________________________|
+
+                     |                                 |
+                     | va                              | va
+                     V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+                     |                                 |
+                     |                                 |
+                     V pa                              V pa
+                 _______________________________________
+                |                                       |
+                |              Memory                   |
+                |_______________________________________|
+
+
+
+Architecture
+------------
+
+Uacce is the kernel module, taking charge of iommu and address sharing.
+The user drivers and libraries are called WarpDrive.
+
+The uacce device, built around the IOMMU SVA API, can access multiple
+address spaces, including the one without PASID.
+
+A virtual concept, queue, is used for the communication. It provides a
+FIFO-like interface. And it maintains a unified address space between the
+application and all involved hardware.
+
+::
+
+                             ___________________                  ________________
+                            |                   |   user API     |                |
+                            | WarpDrive library | ------------>  |  user driver   |
+                            |___________________|                |________________|
+                                     |                                    |
+                                     |                                    |
+                                     | queue fd                           |
+                                     |                                    |
+                                     |                                    |
+                                     v                                    |
+     ___________________         _________                                |
+    |                   |       |         |                               | mmap memory
+    | Other framework   |       |  uacce  |                               | r/w interface
+    | crypto/nic/others |       |_________|                               |
+    |___________________|                                                 |
+             |                       |                                    |
+             | register              | register                           |
+             |                       |                                    |
+             |                       |                                    |
+             |                _________________       __________          |
+             |               |                 |     |          |         |
+              -------------  |  Device Driver  |     |  IOMMU   |         |
+                             |_________________|     |__________|         |
+                                     |                                    |
+                                     |                                    V
+                                     |                            ___________________
+                                     |                           |                   |
+                                     --------------------------  |  Device(Hardware) |
+                                                                 |___________________|
+
+
+How does it work
+----------------
+
+Uacce uses mmap and IOMMU to play the trick.
+
+Uacce creates a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used
+as the user handle of the queue.
+The accelerator device present itself as an Uacce object, which exports as
+a chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+The control path to the hardware is via file operation, while data path is
+via mmap space of the queue fd.
+
+The queue file address space:
+
+::
+
+   /**
+   * enum uacce_qfrt: qfrt type
+   * @UACCE_QFRT_MMIO: device mmio region
+   * @UACCE_QFRT_DUS: device user share region
+   */
+  enum uacce_qfrt {
+          UACCE_QFRT_MMIO = 0,
+          UACCE_QFRT_DUS = 1,
+  };
+
+All regions are optional and differ from device type to type.
+Each region can be mmapped only once, otherwise -EEXIST returns.
+
+The device mmio region is mapped to the hardware mmio space. It is generally
+used for doorbell or other notification to the hardware. It is not fast enough
+as data channel.
+
+The device user share region is used for share data buffer between user process
+and device.
+
+
+The Uacce register API
+----------------------
+
+The register API is defined in uacce.h.
+
+::
+
+  struct uacce_interface {
+    char name[UACCE_MAX_NAME_SIZE];
+    unsigned int flags;
+    const struct uacce_ops *ops;
+  };
+
+According to the IOMMU capability, uacce_interface flags can be:
+
+::
+
+  /**
+   * UACCE Device flags:
+   * UACCE_DEV_SVA: Shared Virtual Addresses
+   *              Support PASID
+   *              Support device page faults (PCI PRI or SMMU Stall)
+   */
+  #define UACCE_DEV_SVA               BIT(0)
+
+  struct uacce_device *uacce_alloc(struct device *parent,
+                                   struct uacce_interface *interface);
+  int uacce_register(struct uacce_device *uacce);
+  void uacce_remove(struct uacce_device *uacce);
+
+uacce_register results can be:
+
+a. If uacce module is not compiled, ERR_PTR(-ENODEV)
+
+b. Succeed with the desired flags
+
+c. Succeed with the negotiated flags, for example
+
+  uacce_interface.flags = UACCE_DEV_SVA but uacce->flags = ~UACCE_DEV_SVA
+
+  So user driver need check return value as well as the negotiated uacce->flags.
+
+
+The user driver
+---------------
+
+The queue file mmap space will need a user driver to wrap the communication
+protocol. Uacce provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+More details in Documentation/ABI/testing/sysfs-driver-uacce.
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
