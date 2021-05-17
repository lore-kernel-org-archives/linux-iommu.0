Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A68C43460
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E61610CB
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E61610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E567060902;
	Mon, 17 May 2021 10:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ik2BBTd6_fQE; Mon, 17 May 2021 10:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A8C60A49;
	Mon, 17 May 2021 10:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B380C000D;
	Mon, 17 May 2021 10:02:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2156C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F8F483AAF
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMbeWitL8rDm for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB51082813
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:45 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id m190so4296756pga.2
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iU39BPoZqk2HqORX3UA9Ncb7R+Ai9Wci3A+87yTYnGc=;
 b=vJS0FLHo+jEjRSpl4KDvMAXIKV6coCiING2EQZA1u2Y7gKzBes8Am7G0tgOJgxQlrZ
 Bkdd4TMVPeYuCtXAnN7lHvgd+fGo5r7S18DNsqWRS/+zLqnQXdMn4+dWRtxgaHnmabi7
 THQzQT3wQSsMuC7EE60tyCdc6m40mjKDwjpd/1WW7rO963r/zo6y3sBIX7e5E2Mp0D7e
 wV5rIuUrhiuPXFHAatRod8B2KEBFLN32CdPEoRTra2ZEhpJqs8EuDriMsfg43ibR1sFY
 E1p+zen4658VBftZ+03vFxrfs5JNVUwGNM8ZRnujdVaAFuKkf2tNZ8xNjzcx1TST/zJB
 o6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iU39BPoZqk2HqORX3UA9Ncb7R+Ai9Wci3A+87yTYnGc=;
 b=Ir5YuaScRMhQrNDOhVWw/f3AUo+AKC7DGdTNEKuID6SZhgzojkKM0+EP/bs5fSNHZ3
 RMimON253WcSJPgnV7rh5aXcJf+rkRnxYk5tXeZgJoZHjFeVgN1kSZT6ksot0PIw8AkR
 wUJuyCXAg/wQrt/6I432EKklFs+/S64XFocgE9A0xyfY7fDiDTbX3FeUUuCO3773clzc
 fNLW8cW3o1fRwEdfwJ5l7X39fUahqEedvJ8vFd6mqRlFejE+mlNFtvi1yHcYN9bMh56m
 PC2ZNjokJhJg9LgbdhR/c9ZEk+B/PBMotr7L62RqENf70yQg1VODwRJ8lM1JE/aq5TpR
 Nosw==
X-Gm-Message-State: AOAM531cRVgikVdbNYANyf45bILHUq3AtjO3Rp9yUr5OoC5Heds5jU8z
 n6Se2gd0aq3qSILdkCQukbRl
X-Google-Smtp-Source: ABdhPJwaUmuqxTT6QOW1/dIV2zi3/klVmP6fV6W/ZGKjYhDf6qJpzO5wUPp9BNC/Sl2so2TDfCiGJg==
X-Received: by 2002:a63:6f8e:: with SMTP id
 k136mr61696699pgc.326.1621245405101; 
 Mon, 17 May 2021 02:56:45 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id v14sm10441643pgl.86.2021.05.17.02.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:44 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 12/12] Documentation: Add documentation for VDUSE
Date: Mon, 17 May 2021 17:55:13 +0800
Message-Id: <20210517095513.850-13-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 May 2021 10:01:55 +0000
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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
 Documentation/userspace-api/vduse.rst | 243 ++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 Documentation/userspace-api/vduse.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index d29b020e5622..2dc25dd9f2aa 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -25,6 +25,7 @@ place where this information is gathered.
    iommu
    media/index
    sysfs-platform_profile
+   vduse
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
new file mode 100644
index 000000000000..a804be347545
--- /dev/null
+++ b/Documentation/userspace-api/vduse.rst
@@ -0,0 +1,243 @@
+==================================
+VDUSE - "vDPA Device in Userspace"
+==================================
+
+vDPA (virtio data path acceleration) device is a device that uses a
+datapath which complies with the virtio specifications with vendor
+specific control path. vDPA devices can be both physically located on
+the hardware or emulated by software. VDUSE is a framework that makes it
+possible to implement software-emulated vDPA devices in userspace.
+
+In general, the userspace process that emulates the device is able to
+run unprivileged. And to reduce security risks, we only support emulating
+a few vDPA devices by default, including: virtio-net device, virtio-blk
+device, virtio-scsi device and virtio-fs device. Only when a sysadmin trusts
+the userspace process enough, it can relax the limitation with a
+'allow_unsafe_device_emulation' module parameter.
+
+How VDUSE works
+===============
+
+Start/Stop VDUSE devices
+------------------------
+
+VDUSE devices are started as follows:
+
+1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
+   /dev/vduse/control.
+
+2. Begin processing VDUSE messages from /dev/vduse/$NAME. The first
+   messages will arrive while attaching the VDUSE instance to vDPA.
+
+3. Send the VDPA_CMD_DEV_NEW netlink message to attach the VDUSE
+   instance to vDPA.
+
+VDUSE devices are stopped as follows:
+
+1. Send the VDPA_CMD_DEV_DEL netlink message to detach the VDUSE
+   instance to vDPA.
+
+2. Close the file descriptor referring to /dev/vduse/$NAME
+
+3. Destroy the VDUSE instance with ioctl(VDUSE_DESTROY_DEV) on
+   /dev/vduse/control
+
+The netlink messages metioned above can be sent via vdpa tool in iproute2
+or use the below sample codes:
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
+Emulate VDUSE devices
+---------------------
+
+To emulate a VDUSE device, we always need to implement both control path
+and data path for it.
+
+To implement control path, a message-based communication protocol and some
+types of control messages are introduced in the VDUSE framework:
+
+- VDUSE_SET_VQ_ADDR: Set the vring address of virtqueue.
+
+- VDUSE_SET_VQ_NUM: Set the size of virtqueue
+
+- VDUSE_SET_VQ_READY: Set ready status of virtqueue
+
+- VDUSE_GET_VQ_READY: Get ready status of virtqueue
+
+- VDUSE_SET_VQ_STATE: Set the state for virtqueue
+
+- VDUSE_GET_VQ_STATE: Get the state for virtqueue
+
+- VDUSE_SET_FEATURES: Set virtio features supported by the driver
+
+- VDUSE_GET_FEATURES: Get virtio features supported by the device
+
+- VDUSE_SET_STATUS: Set the device status
+
+- VDUSE_GET_STATUS: Get the device status
+
+- VDUSE_SET_CONFIG: Write to device specific configuration space
+
+- VDUSE_GET_CONFIG: Read from device specific configuration space
+
+- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping in device IOTLB
+
+Those control messages are mostly based on the vdpa_config_ops in
+include/linux/vdpa.h which defines a unified interface to control
+different types of vdpa device. Userspace needs to read()/write()
+on /dev/vduse/$NAME to receive/reply those control messages
+from/to VDUSE kernel module as follows:
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
+In the data path, vDPA device's iova regions will be mapped into userspace
+with the help of VDUSE_IOTLB_GET_FD ioctl on /dev/vduse/$NAME:
+
+- VDUSE_IOTLB_GET_FD: get the file descriptor to the first overlapped iova region.
+  Userspace can access this iova region by passing fd and corresponding size, offset,
+  perm to mmap(). For example:
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
+		entry.last = iova + 1;
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
+		/* do something to cache this iova region */
+
+		return addr + iova - entry.start;
+	}
+
+Besides, the following ioctls on /dev/vduse/$NAME are provided to support
+interrupt injection and setting up eventfd for virtqueue kicks:
+
+- VDUSE_VQ_SETUP_KICKFD: set the kickfd for virtqueue, this eventfd is used
+  by VDUSE kernel module to notify userspace to consume the vring.
+
+- VDUSE_INJECT_VQ_IRQ: inject an interrupt for specific virtqueue
+
+- VDUSE_INJECT_CONFIG_IRQ: inject a config interrupt
+
+MMU-based IOMMU Driver
+======================
+
+VDUSE framework implements an MMU-based on-chip IOMMU driver to support
+mapping the kernel DMA buffer into the userspace iova region dynamically.
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
