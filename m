Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E8C34022
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7528B2067D
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQoySoW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7528B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C36C87082;
	Mon, 17 Feb 2020 19:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFi8rnaC2iWt; Mon, 17 Feb 2020 19:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D42FB85C9D;
	Mon, 17 Feb 2020 19:51:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF13CC089F;
	Mon, 17 Feb 2020 19:51:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98590C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 877AE854EF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rRkYAvRBk6Ng for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:51:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AB2F981BDF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581969063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=k0Chcwf/bsLQkQ/EVoH3LvBOp4tQlHkngFIxzFLsbIQ=;
 b=YQoySoW65LO3VFHWCZz7XzSN+iaLqyYArgOllSX1Dv/sa+MgRYBywN4wv8uHk8UTx+2I1K
 hv3GXaUAEqfAYik4VZ1Ps+J/jR0BVbaGqcu9op7QyKpdfG3PPqLc7H8VRe/0JA/bR+h9ao
 C8+i96MBMm80Zkp0RBxlSwIEFKC/gzE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-yPTiz3PJPEiasE2HG74dKg-1; Mon, 17 Feb 2020 14:51:01 -0500
Received: by mail-qk1-f200.google.com with SMTP id w29so12550446qkw.1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=k0Chcwf/bsLQkQ/EVoH3LvBOp4tQlHkngFIxzFLsbIQ=;
 b=j4kOv1B8/CZXHWuZDsC9330GRifYHBlbbyQ1R8u/u6/fj1QkLboU+1z6tLBr7KCEJI
 0Lgu3/TP2GI5GK01vl/RjN/uh5Um3bsEx8PEHY8c9l1PMdfMeQhPlSnZBqejlzMZNH3/
 Ln8EAJX+2NrOamv2y1jI9mZ4oQO0wsojVXpr3F0cnSM0ORqnN1JEakvbfkZpxqd8ShA1
 nVo60kahfI7nISNAUmRJOWX7FjPo0Cv1iWDsxjw9K+Q7momBxOVnjQTF6F9vydaNreez
 U74F9Ndn6mJa7ZEuBDCKMtG5Ij2b1L9FEy6ZJCPmHHPvVxC24wx6+1GzOUuKYQCQdiQ7
 GB5Q==
X-Gm-Message-State: APjAAAXYlKNz2rkx94Mhqp97Gmt8dQYFvm4ZBl+Fwz0l5VN/py4G5+/h
 CxV7AKRf5QidWxZIoMyQcq7GXaP0ygTZwD+IVqRarUMnnO/SOzMAPKvcl5gGnYtOIXL2tUN2/7S
 m70e637kk+Dt6+9GT8qD8qSNs9nLolQ==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr14422063qth.187.1581969061343; 
 Mon, 17 Feb 2020 11:51:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8naZM+WMKHD78gxMUMOBP7WY6Lu7S+z2iYJK0VTmyeX2Ylddr5klNyTj63j8jue71ybf8qA==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr14422053qth.187.1581969061109; 
 Mon, 17 Feb 2020 11:51:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id d2sm741039qko.110.2020.02.17.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:51:00 -0800 (PST)
Date: Mon, 17 Feb 2020 12:50:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into
 helper function
Message-ID: <20200217195059.bcvht2m252msrnt5@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-3-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-3-joro@8bytes.org>
X-MC-Unique: yPTiz3PJPEiasE2HG74dKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Move the code that does the deferred device attachment into a separate
>helper function.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
