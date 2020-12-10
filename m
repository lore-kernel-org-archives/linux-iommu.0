Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53006C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 09:13:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE7F2343B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE7F2343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 711E5870C9;
	Thu, 10 Dec 2020 09:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5+Ov8sAIqku; Thu, 10 Dec 2020 09:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF2C7870BD;
	Thu, 10 Dec 2020 09:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6708C0FA7;
	Thu, 10 Dec 2020 09:13:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5591C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBCA7865C1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rsjRPjZcYLrj for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5148E865A1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:13:32 +0000 (UTC)
Date: Thu, 10 Dec 2020 09:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607591611;
 bh=hn1ShHc9pfnbGf3dnVN26kwiAUdtImkRCBzOXab56Kg=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZxTzhQ2Q6mMBQTxuEkjbGSBVNruSOtsI8r+X9vhc8f2/EpiRypPYxkTT9V9FwPCe4
 hH6w/Sx7Cxmzr5UZl2xunTmbJ8Ji0tS/b+Hp+9N1Fqgop8HvS5mKFYXpUUqGtNjnKN
 WyiRajIEgOovjsrKBujQk6h36JGkQN1A5FPnSyIMJ5gPxGV7POkYyBDN9YwoUVTuA5
 1crgA0DpUxOVs1gRir0wew8nsxWhME1E5S4I+HU2dJhs38NK6qLFyMueLl+zsoFGmR
 DT8bXAtUgsI4pYfbBCLiwPpGh/vt3mJ9WnhCajtpRjn02sdwa5KuvU2p/EYF7NaW6W
 J83WjjcziSxDQ==
From: Will Deacon <will@kernel.org>
To: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Subject: Re: [PATCH] drivers/iommu: fix a null-ptr-deref bug in msm_iommu.c
Message-ID: <20201210091326.GA9633@willie-the-truck>
References: <20201206094351.47860-1-tzh18@mails.tsinghua.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201206094351.47860-1-tzh18@mails.tsinghua.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Sun, Dec 06, 2020 at 01:43:51AM -0800, tangzhenhao wrote:
> At line 600 in drivers/iommu/msm_iommu.c, the ret-val of kzalloc should be checked to avoid null-ptr-deref bug.

There's no need to mention the line number of the file name in the commit
message -- that information is already available in the diff. Instead,
please try to describe the problem that you're solving.

Have a look at Documentation/process/submitting-patches.rst.

> Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
> ---
>  drivers/iommu/msm_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3615cd6241c4..e3c576e5babb 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -598,6 +598,10 @@ static void insert_iommu_master(struct device *dev,
>  
>  	if (list_empty(&(*iommu)->ctx_list)) {
>  		master = kzalloc(sizeof(*master), GFP_ATOMIC);
> +		if (!master) {
> +			dev_err(dev, "Failed to allocate IOMMU context bank instance\n");

No need to print an error here -- kzalloc should be plenty noisy enough
if an atomic allocation fails.

> +			return;

Hmm, and then what? We haven't propagated the error, so how much further do
we get?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
