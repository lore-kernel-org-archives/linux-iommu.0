Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5DC4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 14:36:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F220896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 14:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AF7D7C3F;
	Tue, 11 Jun 2019 14:35:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2875EA55
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 14:35:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D65247F8
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 14:35:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75460337;
	Tue, 11 Jun 2019 07:35:57 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5103D3F557;
	Tue, 11 Jun 2019 07:35:56 -0700 (PDT)
Subject: Re: [PATCH 4/8] iommu/arm-smmu-v3: Add support for Substream IDs
To: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-5-jean-philippe.brucker@arm.com>
	<20190611111939.000030e9@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <75ceb6d5-9717-3945-364b-f2374a705697@arm.com>
Date: Tue, 11 Jun 2019 15:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611111939.000030e9@huawei.com>
Content-Language: en-US
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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

On 11/06/2019 11:19, Jonathan Cameron wrote:
>> +static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
>> +				    struct arm_smmu_master *master)
>> +{
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>>  
>> -	cfg->cdptr[0] = cpu_to_le64(val);
>> +	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
>> +	cfg->s1cdmax = master->ssid_bits;
>> +	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
>> +}
>>  
>> -	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
>> -	cfg->cdptr[1] = cpu_to_le64(val);
> 
> Hmm. Diff was having a field day in trying to make the patch as unreadable as possible..

Ugh, yes. This part is a bit more readable with --patience, but I'll
also try to split the patch as you suggest

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
