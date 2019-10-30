Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1ACA9EAF
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 09:24:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8CB205ED
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 09:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8CB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D090FEF0;
	Wed, 30 Oct 2019 09:24:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 52EEBEEB
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 09:24:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DC5498A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 09:24:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 0617E34A; Wed, 30 Oct 2019 10:24:36 +0100 (CET)
Date: Wed, 30 Oct 2019 10:24:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] iommu/amd: Apply the same IVRS IOAPIC workaround to Acer
	Aspire A315-41
Message-ID: <20191030092433.GA5968@8bytes.org>
References: <20191021151721.12393-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191021151721.12393-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Oct 21, 2019 at 05:17:21PM +0200, Takashi Iwai wrote:
> Acer Aspire A315-41 requires the very same workaround as the existing
> quirk for Dell Latitude 5495.  Add the new entry for that.
> 
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1137799
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/iommu/amd_iommu_quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied for v5.4, thanks Takashi.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
