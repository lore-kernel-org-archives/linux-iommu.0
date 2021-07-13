Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E543C07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C21C613A9
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C21C613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F140E40600;
	Tue, 13 Jul 2021 08:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSSG3SBxysxV; Tue, 13 Jul 2021 08:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D9354061A;
	Tue, 13 Jul 2021 08:48:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEB07C0022;
	Tue, 13 Jul 2021 08:48:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4EACC0022
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4908401C7
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RSNykA23voFa for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:48:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B6FB400FE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:48:27 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 g4-20020a17090ace84b029017554809f35so895799pju.5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uMm6a9p0EzX9DUYqGCBIk5+JBvK8mtKaW/5v/siepz8=;
 b=FwrQiD+0uRPLUN+6Ju88xP5C02Bvk9OqVShw9WcsJdiLxu+YCLfDld1XCGfjLU1nSl
 918yKE4A5ColszxQDG/4pM1sXcDtN4ghfirvX+RsqtkNJyYamqqNi2VjbvDtJuJMdMEH
 DBnVAKFBCd1A3Mu8H5eyl/2LzIPpp/+RJW7nXs1sv+9wD9NX2G2ZW51nr6oAKS/uh/Re
 no24BT5m/sJN3evL+WSKCld+Bzy52NIw84s+0QKBgTE+n5jtfL7elaULaVgn89viBuwz
 oYoSGCLRyfky8JDQWJQ44g6XrECuYo7lecJLBNwO2UB7NYtQMZoIpWP32eSw3XP6Zz0y
 tt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uMm6a9p0EzX9DUYqGCBIk5+JBvK8mtKaW/5v/siepz8=;
 b=frtnYMdpvxdQF2fT2bYJWDK8pgfSSyKtmFeg96RZyvhRsB36uKD7raMD4VssrJV7Ae
 zQHd+7EmMC2XlCyw9nmznXnS2i7EzJVq+BajFIoGr1PnCQdzWC6+MdfK9rDg/6Y+IaiS
 NaDWzaFFr+3GRJybhgDsn33D8MCitpEeq5GWc7xT3CK4s0lUXQ0EbtUl97+MddJCIOy4
 phWsgt3Z8TDrsg0N42lCvI5SKyBMq16jb1YhHZ3R5y3Guqpzqt6UBt6tvMDA2KANXO/1
 bd8Y12MpC6PsrMqJBLwgRzOj37ypplMvrw+8ji0PDimA50TLmud2NTLC0KeW5bz2MwsJ
 Qe7A==
X-Gm-Message-State: AOAM531iHR9NKa58SJfbydRJvpPS09ERZFuWRdwCSXW+IrwZV+xlpirp
 mqxvs7QJMJ5T8IwmCtkSLVIe
X-Google-Smtp-Source: ABdhPJy41kKAoDHW9SvVVXjbdWKoO4Hb5f5MeAoUzDaUJYwvEJY6gTCT1v+c76dyqcdtmYhkN5UdhA==
X-Received: by 2002:a17:90a:8585:: with SMTP id
 m5mr3319949pjn.224.1626166106915; 
 Tue, 13 Jul 2021 01:48:26 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id a23sm17961927pff.43.2021.07.13.01.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:48:26 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 17/17] Documentation: Add documentation for VDUSE
Date: Tue, 13 Jul 2021 16:46:56 +0800
Message-Id: <20210713084656.232-18-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

VDUSE (vDPA Device in Userspace) is a framework to support
implementing software-emulated vDPA devices in userspace. This
document is intended to clarify the VDUSE design and usage.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 Documentation/userspace-api/index.rst |   1 +
 Documentation/userspace-api/vduse.rst | 248 ++++++++++++++++++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 Documentation/userspace-api/vduse.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 0b5eefed027e..c432be070f67 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -27,6 +27,7 @@ place where this information is gathered.
    iommu
    media/index
    sysfs-platform_profile
+   vduse
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
new file mode 100644
index 000000000000..2c0d56d4b2da
--- /dev/null
+++ b/Documentation/userspace-api/vduse.rst
@@ -0,0 +1,248 @@
+==================================
+VDUSE - "vDPA Device in Userspace"
+==================================
+
+vDPA (virtio data path acceleration) device is a device that uses a
+datapath which complies with the virtio specifications with vendor
+specific control path. vDPA devices can be both physically located on
+the hardware or emulated by software. VDUSE is a framework that makes it
+possible to implement software-emulated vDPA devices in userspace. And
+to make the device emulation more secure, the emulated vDPA device's
+control path is handled in the kernel and only the data path is
+implemented in the userspace.
+
+Note that only virtio block device is supported by VDUSE framework now,
+which can reduce security risks when the userspace process that implements
+the data path is run by an unprivileged user. The support for other device
+types can be added after the security issue of corresponding device driver
+is clarified or fixed in the future.
+
+Start/Stop VDUSE devices
+------------------------
+
+VDUSE devices are started as follows:
+
+1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
+   /dev/vduse/control.
+
+2. Setup each virtqueue with ioctl(VDUSE_VQ_SETUP) on /dev/vduse/$NAME.
+
+3. Begin processing VDUSE messages from /dev/vduse/$NAME. The first
+   messages will arrive while attaching the VDUSE instance to vDPA bus.
+
+4. Send the VDPA_CMD_DEV_NEW netlink message to attach the VDUSE
+   instance to vDPA bus.
+
+VDUSE devices are stopped as follows:
+
+1. Send the VDPA_CMD_DEV_DEL netlink message to detach the VDUSE
+   instance from vDPA bus.
+
+2. Close the file descriptor referring to /dev/vduse/$NAME.
+
+3. Destroy the VDUSE instance with ioctl(VDUSE_DESTROY_DEV) on
+   /dev/vduse/control.
+
+The netlink messages can be sent via vdpa tool in iproute2 or use the
+below sample codes:
+
+.. code-block:: c
+
+	static int netlink_add_vduse(const char *name, enum vdpa_command cmd)
+	{
+		struct nl_sock *nlsock;
+		struct nl_msg *msg;
+		int famid;
+
+		nlsock = nl_socket_alloc();
+		if (!nlsock)
+			return -ENOMEM;
+
+		if (genl_connect(nlsock))
+			goto free_sock;
+
+		famid = genl_ctrl_resolve(nlsock, VDPA_GENL_NAME);
+		if (famid < 0)
+			goto close_sock;
+
+		msg = nlmsg_alloc();
+		if (!msg)
+			goto close_sock;
+
+		if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0, cmd, 0))
+			goto nla_put_failure;
+
+		NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
+		if (cmd == VDPA_CMD_DEV_NEW)
+			NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
+
+		if (nl_send_sync(nlsock, msg))
+			goto close_sock;
+
+		nl_close(nlsock);
+		nl_socket_free(nlsock);
+
+		return 0;
+	nla_put_failure:
+		nlmsg_free(msg);
+	close_sock:
+		nl_close(nlsock);
+	free_sock:
+		nl_socket_free(nlsock);
+		return -1;
+	}
+
+How VDUSE works
+---------------
+
+As mentioned above, a VDUSE device is created by ioctl(VDUSE_CREATE_DEV) on
+/dev/vduse/control. With this ioctl, userspace can specify some basic configuration
+such as device name (uniquely identify a VDUSE device), virtio features, virtio
+configuration space, bounce buffer size and so on for this emulated device. Then
+a char device interface (/dev/vduse/$NAME) is exported to userspace for device
+emulation. Userspace can use the VDUSE_VQ_SETUP ioctl on /dev/vduse/$NAME to
+add per-virtqueue configuration such as the max size of virtqueue to the device.
+
+After the initialization, the VDUSE device can be attached to vDPA bus via
+the VDPA_CMD_DEV_NEW netlink message. Userspace needs to read()/write() on
+/dev/vduse/$NAME to receive/reply some control messages from/to VDUSE kernel
+module as follows:
+
+.. code-block:: c
+
+	static int vduse_message_handler(int dev_fd)
+	{
+		int len;
+		struct vduse_dev_request req;
+		struct vduse_dev_response resp;
+
+		len = read(dev_fd, &req, sizeof(req));
+		if (len != sizeof(req))
+			return -1;
+
+		resp.request_id = req.request_id;
+
+		switch (req.type) {
+
+		/* handle different types of message */
+
+		}
+
+		len = write(dev_fd, &resp, sizeof(resp));
+		if (len != sizeof(resp))
+			return -1;
+
+		return 0;
+	}
+
+There are now three types of messages introduced by VDUSE framework:
+
+- VDUSE_GET_VQ_STATE: Get the state for virtqueue, userspace should return
+  avail index for split virtqueue or the device/driver ring wrap counters and
+  the avail and used index for packed virtqueue.
+
+- VDUSE_SET_STATUS: Set the device status, userspace should follow
+  the virtio spec: https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html
+  to process this message. For example, fail to set the FEATURES_OK device
+  status bit if the device can not accept the negotiated virtio features
+  get from the VDUSE_GET_FEATURES ioctl.
+
+- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping for specified
+  IOVA range, userspace should firstly remove the old mapping, then setup the new
+  mapping via the VDUSE_IOTLB_GET_FD ioctl.
+
+After DRIVER_OK status bit is set via the VDUSE_SET_STATUS message, userspace is
+able to start the dataplane processing with the help of below ioctls:
+
+- VDUSE_IOTLB_GET_FD: Find the first IOVA region that overlaps with the specified
+  range [start, last] and return the corresponding file descriptor. In vhost-vdpa
+  cases, it might be a full chunk of guest RAM. And in virtio-vdpa cases, it should
+  be the whole bounce buffer or the memory region that stores one virtqueue's
+  metadata (descriptor table, available ring and used ring). Userspace can access
+  this IOVA region by passing fd and corresponding size, offset, perm to mmap().
+  For example:
+
+.. code-block:: c
+
+	static int perm_to_prot(uint8_t perm)
+	{
+		int prot = 0;
+
+		switch (perm) {
+		case VDUSE_ACCESS_WO:
+			prot |= PROT_WRITE;
+			break;
+		case VDUSE_ACCESS_RO:
+			prot |= PROT_READ;
+			break;
+		case VDUSE_ACCESS_RW:
+			prot |= PROT_READ | PROT_WRITE;
+			break;
+		}
+
+		return prot;
+	}
+
+	static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *len)
+	{
+		int fd;
+		void *addr;
+		size_t size;
+		struct vduse_iotlb_entry entry;
+
+		entry.start = iova;
+		entry.last = iova;
+		fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+		if (fd < 0)
+			return NULL;
+
+		size = entry.last - entry.start + 1;
+		*len = entry.last - iova + 1;
+		addr = mmap(0, size, perm_to_prot(entry.perm), MAP_SHARED,
+			    fd, entry.offset);
+		close(fd);
+		if (addr == MAP_FAILED)
+			return NULL;
+
+		/*
+		 * Using some data structures such as linked list to store
+		 * the iotlb mapping. The munmap(2) should be called for the
+		 * cached mapping when the corresponding VDUSE_UPDATE_IOTLB
+		 * message is received or the device is reset.
+		 */
+
+		return addr + iova - entry.start;
+	}
+
+- VDUSE_VQ_GET_INFO: Get the specified virtqueue's information including the size,
+  the IOVAs of descriptor table, available ring and used ring, the state
+  and the ready status. The IOVAs should be passed to the VDUSE_IOTLB_GET_FD ioctl
+  so that userspace can access the descriptor table, available ring and used ring.
+
+- VDUSE_VQ_SETUP_KICKFD: Setup the kick eventfd for the specified virtqueues.
+  The kick eventfd is used by VDUSE kernel module to notify userspace to consume
+  the available ring.
+
+- VDUSE_INJECT_VQ_IRQ: Inject an interrupt for specific virtqueue. It's used to
+  notify virtio driver to consume the used ring.
+
+More details on the uAPI can be found in include/uapi/linux/vduse.h.
+
+MMU-based IOMMU Driver
+----------------------
+
+VDUSE framework implements an MMU-based on-chip IOMMU driver to support
+mapping the kernel DMA buffer into the userspace IOVA region dynamically.
+This is mainly designed for virtio-vdpa case (kernel virtio drivers).
+
+The basic idea behind this driver is treating MMU (VA->PA) as IOMMU (IOVA->PA).
+The driver will set up MMU mapping instead of IOMMU mapping for the DMA transfer
+so that the userspace process is able to use its virtual address to access
+the DMA buffer in kernel.
+
+And to avoid security issue, a bounce-buffering mechanism is introduced to
+prevent userspace accessing the original buffer directly which may contain other
+kernel data. During the mapping, unmapping, the driver will copy the data from
+the original buffer to the bounce buffer and back, depending on the direction of
+the transfer. And the bounce-buffer addresses will be mapped into the user address
+space instead of the original one.
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
