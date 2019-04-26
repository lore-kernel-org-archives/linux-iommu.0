Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13098C43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F56206C1
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F56206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99C1A27E1;
	Fri, 26 Apr 2019 14:16:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CFB7B271F
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:13:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 726F682A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:13:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id A204BD91; Fri, 26 Apr 2019 16:13:41 +0200 (CEST)
Date: Fri, 26 Apr 2019 16:13:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
	linux-arm-msm@vger.kernel.org, dianders@chromium.org,
	hoegsberg@google.com, baolu.lu@linux.intel.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Message-ID: <20190426141341.GB6731@8bytes.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
	<1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
	<20190318095321.GA5417@8bytes.org>
	<20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426141341.MRh34_4jgmBjf315QneIczIraQxtbJUU-s_l2aYm6iA@z>

Hi Jordan,

On Mon, Mar 18, 2019 at 08:19:12AM -0600, Jordan Crouse wrote:
> Adreno GPUs can an internal mechanism to switch the pagetable address in the
> attached arm-smmu v2 IOMMU so that each individual rendering process can have
> their own pagetable. The driver uses iommu_map and iommu_unmap to write
> the pagetable but the address for each individual pagetable needs to be queried
> so it can be sent to the hardware. You can see the driver specific code that
> does this here:

Okay, thanks for the explanation. I still don't like it, but it is
probably better putting gpu-specfic context-switch logic into the iommu
driver, so I guess this is okay.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
