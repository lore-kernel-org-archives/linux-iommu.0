Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E777C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 09:23:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633820716
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 09:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHnTldAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFE6C88117;
	Fri, 20 Dec 2019 09:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNVzTZ-NAeYQ; Fri, 20 Dec 2019 09:23:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4552F880DE;
	Fri, 20 Dec 2019 09:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39C64C1796;
	Fri, 20 Dec 2019 09:23:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37903C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 09:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 220E487FB6
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 09:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPHafnH+2YNC for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 09:23:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2322B87F8B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576833812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=760AfQkQ+/CcCELjUM/zRv4ukeCCbW4IzvgFsX0Yv7E=;
 b=fHnTldAMSMXbvv0B4jM0ei7mJM2uzACZBkiXCYWGJq0uMr2xeC4NKc1gYAMqbJrNIetfi1
 k/Y51StfIc5VwhbMqNAScBVF4zhfDIzpz70ue1UB9INRoQSWSrDgbZ/0rYPpmxMnEE35rs
 y7uJSWv6nnh0Bosak5nSx8c4HTkb5f0=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-I322QJVMOC6G3kwChCHNNA-1; Fri, 20 Dec 2019 04:23:30 -0500
Received: by mail-yw1-f72.google.com with SMTP id 16so6209389ywz.5
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 01:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=760AfQkQ+/CcCELjUM/zRv4ukeCCbW4IzvgFsX0Yv7E=;
 b=NLLboeJQs7+wKmOL1U64P/Vg+jB+6baSZwZwIdvhzaAXolTWmCp1+pMsCuupZpwsLL
 HwqaaJjpI9b2Eue2oav7FBpzAyERdgnbtb91+sJBRUkYppNt1KPWAq8UwmytmgDJxhld
 g/jhvCkSpC6DPNh5SmEqjpesIZ1fFwEHcUsbsOgLm3x/KNQ/+DI60ELz3noPoS4lnESC
 lmULExw6QVF5rh2v1oTDu2yej7bWMHjx1sdh4HZhpmYYv6c4IOOhi5w5ctYMEJRn0w6G
 Pflcb0xAdv4tEO6zPHJSs1CyVJdcqfYKCf6QzSKDe2fjf56xNnWIH0cRMw99qZWRAxjl
 ip/A==
X-Gm-Message-State: APjAAAVS4NmKKMUAPswYZH/4hocRNSx12iogxIfSS1AXb0Gyf3QyRysE
 l0kR12Cextss6fQulpbHxHLisn3F+NlGMDdKZIZlxrvt1fle5I6cR2ifHW7pIxqySQpyGvbuXVM
 Ob3k8sYhvCtaI8grt7ctxQ7QdyvC2Ag==
X-Received: by 2002:a81:3e12:: with SMTP id l18mr4149667ywa.210.1576833809896; 
 Fri, 20 Dec 2019 01:23:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqgiOGz0PxbzXPELzhJrV+QuQMDpbMDOBSl8JJseKtGExzTwa/TU3Ync2h/zYFnA3lZ+KkHg==
X-Received: by 2002:a81:3e12:: with SMTP id l18mr4149654ywa.210.1576833809529; 
 Fri, 20 Dec 2019 01:23:29 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id a202sm3705752ywe.8.2019.12.20.01.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 01:23:28 -0800 (PST)
Date: Fri, 20 Dec 2019 02:23:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: jimyan <jimyan@baidu.com>
Subject: Re: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
Message-ID: <20191220092327.do34gtk3lcafzr6q@cantor>
Mail-Followup-To: jimyan <jimyan@baidu.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
MIME-Version: 1.0
In-Reply-To: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
X-MC-Unique: I322QJVMOC6G3kwChCHNNA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri Dec 20 19, jimyan wrote:
>On a system with an Intel PCIe port configured as a nvme host device, iommu
>initialization fails with
>
>    DMAR: Device scope type does not match for 0000:80:00.0
>
>This is because the DMAR table reports this device as having scope 2
>(ACPI_DMAR_SCOPE_TYPE_BRIDGE):
>

Isn't that a problem to be fixed in the DMAR table then?

>but the device has a type 0 PCI header:
>80:00.0 Class 0600: Device 8086:2020 (rev 06)
>00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
>
>VT-d works perfectly on this system, so there's no reason to bail out
>on initialization due to this apparent scope mismatch. Add the class
>0x600 ("PCI_CLASS_BRIDGE_HOST") as a heuristic for allowing DMAR
>initialization for non-bridge PCI devices listed with scope bridge.
>
>Signed-off-by: jimyan <jimyan@baidu.com>
>---
> drivers/iommu/dmar.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>index eecd6a421667..9faf2f0e0237 100644
>--- a/drivers/iommu/dmar.c
>+++ b/drivers/iommu/dmar.c
>@@ -244,6 +244,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
> 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
> 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
>+			  info->dev->class >> 8 != PCI_CLASS_BRIDGE_HOST &&
> 		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
> 			pr_warn("Device scope type does not match for %s\n",
> 				pci_name(info->dev));
>-- 
>2.11.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
