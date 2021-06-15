Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6232C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:08:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C416128B
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C416128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D4382F37;
	Tue, 15 Jun 2021 19:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VotcKT-EX7Ec; Tue, 15 Jun 2021 19:08:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CF3682EBA;
	Tue, 15 Jun 2021 19:08:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1B4C000D;
	Tue, 15 Jun 2021 19:08:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23932C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11C41600D1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uI8YOYiNlHTK for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:08:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A2F9600B9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:08:03 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id p13so234548pfw.0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ae2/0o2p9fobjBqxoALkWF9ywdZR2o4+z7dG1T9hhvE=;
 b=moY+w+3zlJRsSka3cuNrk2elDxNyX22Y35XGmV3sRiUREDA6f+mUH5aAMNsLGxeBXK
 cyWH9PFKzteJ+Jaa4tfHvtwKk9LwZR2mCKQflJtVinv54C55HPdUYiaRE0/an29biLPY
 pSqOoLvNqmzsbrdrl4WBEmVM4jgTzvr2GPLhWb3D1vPm244t267/9iqSVzIdGthF9vw7
 ljBcEkhs9E/L1/rHlZGe30WNqszF91HgJg9hZVFyeJXZVs00FS95FhJRkXwxPb3GSNej
 mdVVeuAfiA4DqpLsx1YOn/+OuxbgvIvGnXeTaegW6oaC/uJhOiA4korg2mf/ZLB0yvVS
 E0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ae2/0o2p9fobjBqxoALkWF9ywdZR2o4+z7dG1T9hhvE=;
 b=Y/WQ842JUXEjaqctXp2wEv9eVX4i9mTy75uuo+inS/HC/BSPRi5K2Ne7FRXa45Cacg
 AOlSvYDjLH9XonI41ypJgpVEw9swFBPXurvQ3HVQnznoSB9Ew738NSOyFB33d5wZyl7g
 12MWJj2NyHDT2L4VickfLUVZFxMT5BW6nlyy1MSi4DOUYVPZo+uGFltYY7I7h3SIGo/x
 8lKAt4ZNnkK/9/kkOf9GdFIo9k6OSgHx4ErYg1E94NsK7VosEYd6dWMOd3W8pWaQfzwE
 CJk5GBX/G/JTXRs99ZtPh+ZnC9ISTw73wCTO/tVi6cPTk18r6HL0nYZ1n8nM33RoJqw7
 CHSQ==
X-Gm-Message-State: AOAM532X6IfBlnAanyMPyqMDNOEiGqC1BIbD6io7rVZ2Uk3GRPD4D1pV
 0llTb/ofFaqbh8qCe2qKlAU=
X-Google-Smtp-Source: ABdhPJw1d3tMIQI/wuINu5AHxD+9mToBQ4BW24+YNRZuTnOA+mnPEjVM9l0q6fLHB8lV4asimjsgOw==
X-Received: by 2002:a63:4c09:: with SMTP id z9mr957538pga.283.1623784082619;
 Tue, 15 Jun 2021 12:08:02 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id a11sm15589026pjq.45.2021.06.15.12.08.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jun 2021 12:08:02 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
Date: Tue, 15 Jun 2021 12:07:58 -0700
Message-Id: <7A15BB6B-B115-4167-A6AF-E96D71FE9E9E@gmail.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
 <07969028-d807-cad1-2a01-8efc87390157@arm.com>
 <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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



> On Jun 15, 2021, at 12:05 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> 
> 
>> On Jun 15, 2021, at 3:42 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> 
>> On 2021-06-07 19:25, Nadav Amit wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>> The Mediatek driver is not the only one which might want a basic
>>> address-based gathering behaviour, so although it's arguably simple
>>> enough to open-code, let's factor it out for the sake of cleanliness.
>>> Let's also take this opportunity to document the intent of these
>>> helpers for clarity.
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Jiajun Cao <caojiajun@vmware.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Cc: iommu@lists.linux-foundation.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> 
>> Nit: missing your signoff.
>> 
>>> ---
>>> Changes from Robin's version:
>>> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
>> 
>> Out of curiosity, is there any config in which a stub is actually needed? Unlike iommu_iotlb_gather_init(), I would have thought that these helpers should only ever be called by driver code which already depends on IOMMU_API.
> 
> Indeed, this was only done as a defensive step.
> 
> I will remove it. I see no reason for it. Sorry for ruining your patch.

And remove the stub for iommu_iotlb_gather_is_disjoint() as well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
