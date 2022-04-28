Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EFCC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 372FD8146B;
	Thu, 28 Apr 2022 14:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ve-3D_eZbT1H; Thu, 28 Apr 2022 14:12:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E61F813D9;
	Thu, 28 Apr 2022 14:12:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC5AC0032;
	Thu, 28 Apr 2022 14:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44189C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3317B813F4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DR8SKFynXkP5 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:12:42 +0000 (UTC)
X-Greylist: delayed 00:06:16 by SQLgrey-1.8.0
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7757A813D0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:12:42 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 0C7AE37A;
 Thu, 28 Apr 2022 14:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C7AE37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1651154785; bh=Y2xnGB6jAuDv2OSGOPccTS08t10lDzVVPJqY/azBkxg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OVHg3XH3CV9h4WnwpB2QxRGv+qWAAHo4xnpjabp5fV5kID38tVUqBcoQb/pnL6uEW
 8uEBwaOrzPgltzkqwiAkUJC60V7i5i9pZR7pK1CtmDV3is9OmJVRZwY26IjQW7s3jv
 CMCxbmk0SG1T5vMmpG1PCmPYP0uxSUMif3pUTEfWrAsoztJO0y6OCxcBc2p43MALWT
 pCcXF4h/bwXdTG2ys8XqOF4Rw80L06yY/H34TsErdOPu1iyUN00nPKz+p8ysCdsDvv
 iUDXBmLwd0194Q+P+qm6aL4QJMBB9LIJQ9OgFWCrreh39iOIcS05DfDxm+MRr0189i
 Fm/M6V1Cr2zdQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Joerg Roedel <joro@8bytes.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
In-Reply-To: <YmpNevdJFec0+9Mn@8bytes.org>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
 <YmpNevdJFec0+9Mn@8bytes.org>
Date: Thu, 28 Apr 2022 08:06:24 -0600
Message-ID: <87ee1h8fq7.fsf@meer.lwn.net>
MIME-Version: 1.0
Cc: dave.hansen@linux.intel.com, linux-doc@vger.kernel.org,
 robin.murphy@arm.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Vasant.Hegde@amd.com, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, will@kernel.org
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

Joerg Roedel <joro@8bytes.org> writes:

> Acked-by: Joerg Roedel <jroedel@suse.de>
>
> Jonathan, will you merge that through the documentation tree?

Done.

Thanks,

jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
