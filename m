Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DAC43216
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E82B60F23
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E82B60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F391780F70;
	Mon, 30 Aug 2021 14:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXPp1CX8o6gv; Mon, 30 Aug 2021 14:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D9D7C80F6E;
	Mon, 30 Aug 2021 14:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CAAC001A;
	Mon, 30 Aug 2021 14:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED567C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC8DA4045B
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vIH0WOdv23mQ for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:22:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF78C403B9
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 14:22:41 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 j4-20020a17090a734400b0018f6dd1ec97so101014pjs.3
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nNh+cuhjJs3OFS0aHfl+SKfylhnWyvpkdBMP+CFmcGQ=;
 b=s02XABZpmgPpHcsFgcJcjjv842DYHb+mw0yfIcrk1Sl2dJot0PXyPr9GhpABt1Vv9U
 x/YFw2Xit0ZA8WFjfwobTx+T+qUZmYP8Ef07/8KfJ/EecP9VRqMrYjab4SxBEmVVJIfI
 N0O5Bi9rAL84nn9yJuoFUsez0axbemCk0eRtPqvKNlNcxWurRsNwGdFZXfwWuw3/c+Km
 MYvFhZLUCd+bJFzD3TWzCYoud3blRz3yDQcs+xC7aqs0ZszT+99fOW5GCP7JVsmrIv1F
 ux0RWeakr9j7WPdPNrGYUxoSzUWlPsvIuosQvcKF2sQXCAt1GickCnNGdFXmYOUVkAzq
 7mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nNh+cuhjJs3OFS0aHfl+SKfylhnWyvpkdBMP+CFmcGQ=;
 b=iHqH6mIpyRofusE3wbkphaxXu6z7NzoOwXggua2r9AC64TDjKNShmWOIYdVu0Gal1e
 9XUljO79nFW1A60AQRlYJdJgXig0J9FwRYQQ21YaXCmpiJft5QqVeUSRn/Lku8ytV0Or
 1V1lwNit2InpXK8WeJE81vy9VZRSB8mDQJkshTTl+ErQdpwq5CObhJZ1oU4Dvgqy4aAI
 z7/wdX65uPw0/Mr3mk3QfaOmcZOe6KyYcx8OJhhMGEji3eXwMXeqcB2X2bg5IDwqUg8l
 xvO4nLoBMA/T1qcaW3isLH3Z1KBWEhJkU2oypEmaoQLzmxvZPbjZj92qevwhlPpZvfVD
 2f/w==
X-Gm-Message-State: AOAM530S6bwyP4jWoLGRDeRh+iAnuOLwyvGpge1ozaHr0+9jxs1ZOP3F
 D+tP8KNsZBz9iYr5Ty0hdFDT
X-Google-Smtp-Source: ABdhPJxlJ/I4xFkoX1ALvl8O1pLiPV//UuwzwBUlDAOfsbHzsqEtI+y4Dpzs6o9CdNjU8sRLdHZ4yA==
X-Received: by 2002:a17:902:b095:b029:12c:de88:7d3b with SMTP id
 p21-20020a170902b095b029012cde887d3bmr21938939plr.15.1630333361194; 
 Mon, 30 Aug 2021 07:22:41 -0700 (PDT)
Received: from localhost ([139.177.225.237])
 by smtp.gmail.com with ESMTPSA id i1sm20958491pjs.31.2021.08.30.07.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 07:22:40 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
Date: Mon, 30 Aug 2021 22:17:37 +0800
Message-Id: <20210830141737.181-14-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830141737.181-1-xieyongji@bytedance.com>
References: <20210830141737.181-1-xieyongji@bytedance.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
---
 Documentation/userspace-api/index.rst |   1 +
 Documentation/userspace-api/vduse.rst | 233 ++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)
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
index 000000000000..42ef59ea5314
--- /dev/null
+++ b/Documentation/userspace-api/vduse.rst
@@ -0,0 +1,233 @@
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
+Create/Destroy VDUSE devices
+------------------------
+
+VDUSE devices are created as follows:
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
+VDUSE devices are destroyed as follows:
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
+configuration space, the number of virtqueues and so on for this emulated device.
+Then a char device interface (/dev/vduse/$NAME) is exported to userspace for device
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
+		/* handle different types of messages */
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
+  get from the VDUSE_DEV_GET_FEATURES ioctl.
+
+- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping for specified
+  IOVA range, userspace should firstly remove the old mapping, then setup the new
+  mapping via the VDUSE_IOTLB_GET_FD ioctl.
+
+After DRIVER_OK status bit is set via the VDUSE_SET_STATUS message, userspace is
+able to start the dataplane processing as follows:
+
+1. Get the specified virtqueue's information with the VDUSE_VQ_GET_INFO ioctl,
+   including the size, the IOVAs of descriptor table, available ring and used ring,
+   the state and the ready status.
+
+2. Pass the above IOVAs to the VDUSE_IOTLB_GET_FD ioctl so that those IOVA regions
+   can be mapped into userspace. Some sample codes is shown below:
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
+
+		/*
+		 * Find the first IOVA region that overlaps with the specified
+		 * range [start, last] and return the corresponding file descriptor.
+		 */
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
+3. Setup the kick eventfd for the specified virtqueues with the VDUSE_VQ_SETUP_KICKFD
+   ioctl. The kick eventfd is used by VDUSE kernel module to notify userspace to
+   consume the available ring. This is optional since userspace can choose to poll the
+   available ring instead.
+
+4. Listen to the kick eventfd (optional) and consume the available ring. The buffer
+   described by the descriptors in the descriptor table should be also mapped into
+   userspace via the VDUSE_IOTLB_GET_FD ioctl before accessing.
+
+5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_IRQ ioctl
+   after the used ring is filled.
+
+For more details on the uAPI, please see include/uapi/linux/vduse.h.
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
