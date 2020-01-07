Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B0C32771
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:58:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B912072C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2F8KdF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B912072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9B1F120023;
	Tue,  7 Jan 2020 01:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Su3aWTJlZosa; Tue,  7 Jan 2020 01:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9753F20009;
	Tue,  7 Jan 2020 01:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82101C1D82;
	Tue,  7 Jan 2020 01:58:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45E2DC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2EBD48665F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4aceO1MN8WY7 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 01:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6594E863FF
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578362284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jyQyCUdnm21nxv/X1v85w0ZZB+IptGrVE4iTgTEdowY=;
 b=K2F8KdF59WslLGCoBOYJwvW+K96YrABLZegDlt8P0zvioG9MnPP1DVd/Gr/CLMI/+wnys2
 O6jCsxyELXMaqtD8kb9+j+2CaEiv7b4Kd3oxpCBP3VWOBsoDEDQYs5SHetcnggeNIOBd04
 4LPPVZZB86awq/CUsH/jni4S1YkUA98=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-1oT1rMSbOZK2N_9hMQi0bg-1; Mon, 06 Jan 2020 20:58:03 -0500
Received: by mail-yb1-f199.google.com with SMTP id d17so20812263ybl.11
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jan 2020 17:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=jyQyCUdnm21nxv/X1v85w0ZZB+IptGrVE4iTgTEdowY=;
 b=i97e3wGBIKpXDBpmwMNVQK8UETETnkTPc2mD9FSHtYGOErZacCYptmLC0jOWKNbUwc
 2D75yZiOEkx6rtzdUf9T5Um+AUCPxWl9/sCUGdsOCK2qGTR5tG6qUOEtHypd+dK2Lbke
 FLlqpZZPdk9mRkbtJbr8yV4iQ+TlTICt8fn+bn9k7CwWmXRERzjSOP8Fc8AdsM3byFLl
 ffiZ1eRBsvNV2oYQ2RX073Li7CeJgr4Yd7zh/+mtQbQJvb5YuN2TZYgKhpuV4FJFjMCm
 eiuX67+c806Q/UDo6QfJqEffr4mQvDA07sx7lQw1NSqhjsjxWY1Lz3cTFFdRSih+gVx1
 7PVw==
X-Gm-Message-State: APjAAAV1UMdDNB4u59EdJnlOfOPtD6kAJc1GO5zVjrXPw7Eb1Sw92Wrz
 aZnAbqAyf3HjdiwxHkXCmXvHZRGo7XUNpupxnyOhoCL4cTSx3QjA50z0KPNgwefCQzqbbgj30qw
 7e0pVRR3K5WfA+UtSCd6EKplckZV/IA==
X-Received: by 2002:a81:f006:: with SMTP id p6mr66574901ywm.483.1578362282068; 
 Mon, 06 Jan 2020 17:58:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvqRFkGDxsrJ+8LLIv4naaR8AKOgbQL4pZweIB3X64AP5RS7nGjPUpBAxMM3lmB2/+XMItGg==
X-Received: by 2002:a81:f006:: with SMTP id p6mr66574880ywm.483.1578362281516; 
 Mon, 06 Jan 2020 17:58:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id p1sm30612444ywh.74.2020.01.06.17.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 17:58:00 -0800 (PST)
Date: Mon, 6 Jan 2020 18:57:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: jimyan <jimyan@baidu.com>
Subject: Re: [PATCH v2] iommu/vt-d: Don't reject nvme host due to scope
 mismatch
Message-ID: <20200107015759.ukyt73lmdj6rv4eh@cantor>
Mail-Followup-To: jimyan <jimyan@baidu.com>, joro@8bytes.org,
 baolu.lu@linux.intel.com, roland@purestorage.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
MIME-Version: 1.0
In-Reply-To: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
X-MC-Unique: 1oT1rMSbOZK2N_9hMQi0bg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: roland@purestorage.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On Sun Jan 05 20, jimyan wrote:
>On a system with an Intel PCIe port configured as a nvme host device, iommu
>initialization fails with
>
>    DMAR: Device scope type does not match for 0000:80:00.0
>
>This is because the DMAR table reports this device as having scope 2
>(ACPI_DMAR_SCOPE_TYPE_BRIDGE):
>
>but the device has a type 0 PCI header:
>80:00.0 Class 0600: Device 8086:2020 (rev 06)
>00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
>
>VT-d works perfectly on this system, so there's no reason to bail out
>on initialization due to this apparent scope mismatch. Add the class
>0x06 ("PCI_BASE_CLASS_BRIDGE") as a heuristic for allowing DMAR
>initialization for non-bridge PCI devices listed with scope bridge.
>
>Signed-off-by: jimyan <jimyan@baidu.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
