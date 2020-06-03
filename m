Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F99C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120D6207DA
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 07:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7itCp34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120D6207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7353203F5;
	Wed,  3 Jun 2020 07:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDKf+riNRmUx; Wed,  3 Jun 2020 07:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9D9FE20111;
	Wed,  3 Jun 2020 07:25:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC8AC0888;
	Wed,  3 Jun 2020 07:25:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24BC2C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0BF8487EEE
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPIP+0W99wdy for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 07:25:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1982087D91
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591169107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EC+d+WxemCljULP9SuuqZspKAfF5v0XLd3cIFL/Shds=;
 b=X7itCp34Ge6LXUJNBmHsmqtRwvADycY4lnvLWLtzU26FYpZUWs0FS63kfLCXQqRSUlae8x
 zII4MSEJku2s85dxvqHk/zOPtPcudUDIZe7bk04p99SzCGXZXJDiIXI7pfgC9ng+wDUjRU
 G4s3Z0HGEvaAcrxQUl2KePYBOuUN8Sw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-YixV0GQ0OQKtYOba0c7khw-1; Wed, 03 Jun 2020 03:25:06 -0400
X-MC-Unique: YixV0GQ0OQKtYOba0c7khw-1
Received: by mail-qv1-f72.google.com with SMTP id z7so861170qve.0
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 00:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=EC+d+WxemCljULP9SuuqZspKAfF5v0XLd3cIFL/Shds=;
 b=bfAEVQn42BACR7QjEgCAAix9SrMYnsp+scItPffgaJ/1JFeou8wcclMjPuBS9cI//w
 hephuIrXSrWTUt6c9t5LdhQcRevdiykuqTQHsuZ2ezXN+c+qHhTDD1JdOtgGcoO5RPkG
 KtAurQqepnIDkSElRMLnm6BnooEDHo6QsyW/u+gKwt4hiVOfFhCt9RJBq+mV7ZjXnQSl
 RUtJxgHmEXd4EFQK8fAGLs2/aWVSQZ+YvN6NcnTJf2nyUICtjWdp208DEk7YDw+3xLUJ
 SAIKeTVoXq+bMusmoD0rrDH1wrE/qFRoQKBDX+YTGaf45gtsPcby5KGEea+9+uZLdueZ
 bluw==
X-Gm-Message-State: AOAM530E3LNtjhGqpIEuAmjQMswAp1txtwMKYxiUwRknRG4OiELhPJ3L
 FQihUhFepO1oSOdlxdUg/gaCkLPbrhA9N8WFGWevaIF7hXfDRelOXFeTvDiJ4fDzxu5XvzsjiCf
 7ME+w+x/izTVw7Z57d5K2zJonfg22+g==
X-Received: by 2002:a37:850:: with SMTP id 77mr28134177qki.498.1591169105757; 
 Wed, 03 Jun 2020 00:25:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwywfiXv11HyflkYogvBZqV6/H9CCZ3oOPBIMwdCxiPWdRcaBtK8tl9oN/O7TAcINZHy9dowA==
X-Received: by 2002:a37:850:: with SMTP id 77mr28134171qki.498.1591169105494; 
 Wed, 03 Jun 2020 00:25:05 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id 80sm910052qkl.116.2020.06.03.00.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 00:25:04 -0700 (PDT)
Date: Wed, 3 Jun 2020 00:25:03 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
Message-ID: <20200603072503.j5iffuoxkdryg7qa@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200602092616.24638-1-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200602092616.24638-1-joro@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue Jun 02 20, Joerg Roedel wrote:
>Hi,
>
>two small patches to move the Intel and AMD IOMMU drivers into their own
>subdirectory under drivers/iommu/ to make the file structure a bit less
>cluttered.
>
>Regards,
>
>	Joerg
>
>Joerg Roedel (2):
>  iommu/amd: Move AMD IOMMU driver into subdirectory
>  iommu/vt-d: Move Intel IOMMU driver into subdirectory
>
> drivers/iommu/Makefile                         | 18 +++++++++---------
> drivers/iommu/{ => amd}/amd_iommu.h            |  0
> drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
> .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
> drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
> drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
> .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
> .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
> .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
> drivers/iommu/{ => intel}/dmar.c               |  2 +-
> drivers/iommu/{ => intel}/intel-pasid.h        |  0
> drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
> .../irq_remapping.c}                           |  2 +-
> drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
> drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
> drivers/iommu/{intel-trace.c => intel/trace.c} |  0
> 16 files changed, 14 insertions(+), 14 deletions(-)
> rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
> rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
> rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
> rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
> rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
> rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
> rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
> rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
> rename drivers/iommu/{ => intel}/dmar.c (99%)
> rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
> rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
> rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
> rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
> rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
> rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
>
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
