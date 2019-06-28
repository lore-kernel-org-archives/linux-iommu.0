Return-Path: <SRS0=07Ha=U3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3DC4321A
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 09:52:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0801B208E3
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 09:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq+GGSFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D27DEC11;
	Fri, 28 Jun 2019 09:52:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9B2DB9E
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 09:52:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 52CFA82F
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 09:52:56 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 79956208CB;
	Fri, 28 Jun 2019 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561715576;
	bh=Q51/eiDzEzpnoVj8ctpxa2Tb4BnIqmcroS/9YKQAmM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq+GGSFHJu+Su/Qp+Won4cfcJSWBlnH5u2+yXwLrlWgefD7I5ddjIRtd1Ido8Zd8C
	eqxUlwz4AASP7UYd8rThtRn2ldTpBqBRDKz1ePOsKAsVxNQAzRj7fRPFoNV3ol8czJ
	Um5PfXAeX1d5vDpn5HoJ0NOgQQfIbQmwIe8dr3DI=
Date: Fri, 28 Jun 2019 10:52:51 +0100
From: Will Deacon <will@kernel.org>
To: Pratyush Yadav <p-yadav1@ti.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix incorrect fields being passed to
	prefetch command
Message-ID: <20190628095250.bzq4aqyuczt47y4i@willie-the-truck>
References: <20190628090953.23606-1-p-yadav1@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190628090953.23606-1-p-yadav1@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: lokeshvutla@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	wmills@ti.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 28, 2019 at 02:39:53PM +0530, Pratyush Yadav wrote:
> According to the SMMUv3 spec [0] section 4.2.1, command 0x1
> (CMD_PREFETCH_CONFIG) does not take address and size as parameters. It
> only takes  StreamID, SSec, SubstreamID, and SSV. Address and Size are
> parameters for command 0x2 (CMD_PREFETCH_ADDR).
> 
> Tested on kernel 4.19 on TI J721E SOC.
> 
> [0] https://static.docs.arm.com/ihi0070/a/IHI_0070A_SMMUv3.pdf
> 
> Signed-off-by: Pratyush Yadav <p-yadav1@ti.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d5a694f02c2..2d4dfd909436 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -413,6 +413,7 @@ struct arm_smmu_cmdq_ent {
>  	/* Command-specific fields */
>  	union {
>  		#define CMDQ_OP_PREFETCH_CFG	0x1
> +		#define CMDQ_OP_PREFETCH_ADDR	0x2
>  		struct {
>  			u32			sid;
>  			u8			size;
> @@ -805,10 +806,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  	case CMDQ_OP_TLBI_EL2_ALL:
>  	case CMDQ_OP_TLBI_NSNH_ALL:
>  		break;
> -	case CMDQ_OP_PREFETCH_CFG:
> -		cmd[0] |= FIELD_PREP(CMDQ_PREFETCH_0_SID, ent->prefetch.sid);
> +	case CMDQ_OP_PREFETCH_ADDR:
>  		cmd[1] |= FIELD_PREP(CMDQ_PREFETCH_1_SIZE, ent->prefetch.size);
>  		cmd[1] |= ent->prefetch.addr & CMDQ_PREFETCH_1_ADDR_MASK;
> +		/* Fallthrough */
> +	case CMDQ_OP_PREFETCH_CFG:
> +		cmd[0] |= FIELD_PREP(CMDQ_PREFETCH_0_SID, ent->prefetch.sid);

Hmm, but there's no issue here because the onus is on the caller not to
initialise size and addr if they are using PREFETCH_CFG (and this is
currently the case). Are you seeing a problem in practice?

I'm happy to take a patch adding support for PREFETCH_ADDR, but we'd need
a caller first.

Also -- fancy sending me a board? ;)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
