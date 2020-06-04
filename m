Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1BFC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 00:33:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D0E207D0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 00:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP8zHXM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D0E207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B848E86DEC;
	Thu,  4 Jun 2020 00:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ps9LxZ434y7M; Thu,  4 Jun 2020 00:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E38286DE1;
	Thu,  4 Jun 2020 00:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33352C0178;
	Thu,  4 Jun 2020 00:33:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 418F1C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CDD086DE4
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4JIjmzdUhYJ for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 00:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 87D9186DE1
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591230812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z0GcSxT2WNBSxlfmkg95uPwf3ZGL3Q7ykUANj5zGO7w=;
 b=bP8zHXM6BebnlMYBLbVjv6tYBEKzZiDbNmsFoYEDjLRfofs/7fagZmjTJuo0ZWhSb/cFgN
 T9u+g6E8fR/5gk3lvtMQ2xdiw05o+nrJcC8WiVV5suBPzC7redpSwBynPHSij2sjLGW4OT
 bSx4t3bEVvbjXp7K4JEVF6IAsKCI1fM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-w9SSv3v5OS6WWeTCvI_Jeg-1; Wed, 03 Jun 2020 20:33:30 -0400
X-MC-Unique: w9SSv3v5OS6WWeTCvI_Jeg-1
Received: by mail-qk1-f198.google.com with SMTP id x68so3179919qkd.1
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 17:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=z0GcSxT2WNBSxlfmkg95uPwf3ZGL3Q7ykUANj5zGO7w=;
 b=FWFl7ZGlQsFfzqSYAItUcRGxRaD4keaz7bITZAx/TBmZb2xF2Zw0Qdl8jWtwoSAEJg
 p0BOBe1Xu/wPRWRAfGAhMcZnoUVpkKbJwQk5tWGsj4Iw/TTA6XYqCVQEoF2fVNNy+nac
 R17PyvnQO/4Jfz0bQqxRsxymJk9NKH7ZU3j7cVvhnvrq6/UxMQh5ZvXvjsDxr5elO45H
 Cad/yJjLKwW5GdVYKXf9rpGBP7bJhHBbZiK29AxxpiTAMakLoF1vyLY+gyQ3erdEdxUN
 M9mepR9KxQ+2izbMKw/RM8M6gFqGgq26BHbEN/7M/eXxPvqm6LDmoEUDQMnle43C/4nY
 kQWg==
X-Gm-Message-State: AOAM531JAFnoqtQCJrPq7futigjp0jEy8WT1bXUgNQPNoIl0/Boe/fr/
 XeKgGC41Nd/iqcWSrH4MPYcw8qXYI4+VgzGHjI35lqi4ADGWg8Zz2ImGxMCmkdqmR1OdhvR0C3Y
 ob0YEVFD74IVOGk5s6aI3fXF3pqrEuA==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr2001843qtb.210.1591230810244; 
 Wed, 03 Jun 2020 17:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLAqtZLyXW1qmZCBVVBSMCAd/hiQhcdwBWw2XvC2mofMUKO2j+DxwewPxvUEt5AscwPHRMyQ==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr2001822qtb.210.1591230809949; 
 Wed, 03 Jun 2020 17:33:29 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id 5sm2725501qko.14.2020.06.03.17.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 17:33:28 -0700 (PDT)
Date: Wed, 3 Jun 2020 17:33:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
Message-ID: <20200604003327.hk7w7i5qs7z3z2w3@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200602092616.24638-1-joro@8bytes.org>
 <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
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

On Thu Jun 04 20, Lu Baolu wrote:
>Hi Joerg,
>
>On 6/2/20 5:26 PM, Joerg Roedel wrote:
>>Hi,
>>
>>two small patches to move the Intel and AMD IOMMU drivers into their own
>>subdirectory under drivers/iommu/ to make the file structure a bit less
>>cluttered.
>>
>
>Does the MAINTAINERS file need to update?
>
>Best regards,
>baolu
>

Yes, that should be updated to point at the new directories. Good catch.


>>Regards,
>>
>>	Joerg
>>
>>Joerg Roedel (2):
>>   iommu/amd: Move AMD IOMMU driver into subdirectory
>>   iommu/vt-d: Move Intel IOMMU driver into subdirectory
>>
>>  drivers/iommu/Makefile                         | 18 +++++++++---------
>>  drivers/iommu/{ => amd}/amd_iommu.h            |  0
>>  drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
>>  .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
>>  drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
>>  drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
>>  .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
>>  .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
>>  .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
>>  drivers/iommu/{ => intel}/dmar.c               |  2 +-
>>  drivers/iommu/{ => intel}/intel-pasid.h        |  0
>>  drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
>>  .../irq_remapping.c}                           |  2 +-
>>  drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
>>  drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
>>  drivers/iommu/{intel-trace.c => intel/trace.c} |  0
>>  16 files changed, 14 insertions(+), 14 deletions(-)
>>  rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
>>  rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>>  rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
>>  rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>>  rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
>>  rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
>>  rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
>>  rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
>>  rename drivers/iommu/{ => intel}/dmar.c (99%)
>>  rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
>>  rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
>>  rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
>>  rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
>>  rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
>>  rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
>>
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
