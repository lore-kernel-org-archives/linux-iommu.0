Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9BC5ACD7
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936962076C
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 11:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gFYEGhVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936962076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59E7887D31;
	Wed, 18 Mar 2020 11:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RGhPIWvFqJa; Wed, 18 Mar 2020 11:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1C14D87804;
	Wed, 18 Mar 2020 11:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00CD5C07FE;
	Wed, 18 Mar 2020 11:14:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5A4C013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 11:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4ACE486D50
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 11:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cm_6n4r6OGqt for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 11:14:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 542A386D4D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 11:14:27 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id f20so298693qtq.6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=sgyNbxuqyjr0qsNo2fb06dE8sRE+6o19+81LTsUoSA0=;
 b=gFYEGhVsLWDPfb3FaC35adoF5ttqjS3XQlnxbKwP7zr2CA3rvPiHtWlUnOee9N5KDD
 R8EK3pw05OTxaGnz+whhkBEY687jvqKt/vOWv1rQK5EXc50dVaLSBvG23hSUdDn5QUn3
 C2hwmfJhGQEo0CAtdC/S60wNPmxer7D/lhj1rWt9k5mQNGy6c/gwcNcIqc3v8dYyJR16
 Pl/ZZpdrszp1DxAfkTBVqcMKOb/p+6jrVMHeSr1Hq51THjKThrMUYukNj0EuHDDBus4p
 AGeF8iSaDnZnaboV3ok/lfVlHTDxWbnl9z+BggsU5ljj5C3Fx/uXMohmr0zIYx94AnJ8
 hSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=sgyNbxuqyjr0qsNo2fb06dE8sRE+6o19+81LTsUoSA0=;
 b=MOK3PbNKsPVoD0jeHhvjI1VDyqjPa9bw3VjPudovrBNyxavJjTuNFtyq/GLNhLxxi/
 8rkWp40/ulox9l/qrhzd08rKgTM2rSvEfcykKMyhjO2wB7lCM8/GgYPlped7Ni0MDIM7
 TotWvE6p6ktXCHaMh2CcqnJA3quECBtEdRxZ8j2Ztx3LpB0FFr6ERFiEalU6A1w0kpQm
 5hXU48nR7EBN484J5ZOCCqWn6gxDhe3/Mi2j1/ae0RHxOZx2hpOPC6Sbm77uYqUJ5FAE
 1p01vT2R7bFLWUa4l1qmeHS/pw25RJhF9BOePgnETjMAkC/W/c0iXNzuFNa4T/N64w9s
 5EYA==
X-Gm-Message-State: ANhLgQ1Ptv7Y4xEpCdHxkUxcn93aPu9Vsf+2ueoctAJppQCoHR52jsEE
 Lk4BemhdsPA1lF5VqD2E1zqv4w==
X-Google-Smtp-Source: ADFU+vungW6oo2qwG68CHP49iz0ohwYX3aEM++C6PAJnfZNPYYQOtB0SXA4Gw6VHTcAL2kirl1VGAQ==
X-Received: by 2002:ac8:3141:: with SMTP id h1mr3836627qtb.108.1584530066205; 
 Wed, 18 Mar 2020 04:14:26 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id g6sm4145161qtd.85.2020.03.18.04.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 04:14:25 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
Date: Wed, 18 Mar 2020 07:14:24 -0400
Message-Id: <3F34A59D-2EB6-48A9-B758-2CB8B2EA1128@lca.pw>
References: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
In-Reply-To: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17D50)
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
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



> On Mar 18, 2020, at 1:27 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> How about changing the commit subject to
> "iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()"?

Just a bit long which should be non-issue.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
