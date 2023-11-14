Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5F16412
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y2ZS+vVP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9rv35011818;
	Tue, 14 Nov 2023 10:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3zTC19EFKQKE61sJzUZb97ngfh32j2pj5owHzT7XlW4=;
 b=Y2ZS+vVPkWq+tKhHpPP/qKduMnMAf/o96Qy80uLariRVvknDDNPK1d6WtMUyoRO9zeuJ
 7V6fsxLzLq54w1WoO0HWc9zm9grwinVulj/4DnDyUtrxbNcd/NhGpAG9Ks7eI0AUdeKt
 waxDLqlYntiJZJ1cQsORpnw3J4XARs3mozBilsFYV25UgLRQPlorZ9+sib3Uv4LSjJaQ
 +skBz6mIcZRmV0n8m2MEsQoshWOB2MelK1sIbsgUCT8EffmM5q/EOwFgl/HHi+QTwDlf
 i8jO31IxxX3KcPoKFftVz0G09T9m6bFKhyiudM8afMzqgV+XtTCK5myO6LPJ/7W85UeF Uw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uc6nug1nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 10:20:34 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEAKYMZ020162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 10:20:34 GMT
Received: from [10.214.66.253] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 02:20:29 -0800
Message-ID: <3e1e38ed-8e5f-455e-8ab9-e5be2fb9a493@quicinc.com>
Date: Tue, 14 Nov 2023 15:50:20 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <a39.skl@gmail.com>, <konrad.dybcio@linaro.org>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-2-quic_bibekkum@quicinc.com>
 <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
 <212c4f7f-4b22-4e21-9848-906bbfd69f0e@quicinc.com>
In-Reply-To: <212c4f7f-4b22-4e21-9848-906bbfd69f0e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VVuJ5AdpFlGsHBPf2yNjt_tsDeTFAchC
X-Proofpoint-GUID: VVuJ5AdpFlGsHBPf2yNjt_tsDeTFAchC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140081



On 11/6/2023 11:42 AM, Bibek Kumar Patro wrote:
> 
> 
> On 11/4/2023 3:33 AM, Dmitry Baryshkov wrote:
>> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which 
>>> allows
>>> the TLB to fetch just the next page table. MMU-500 features ACTLR
>>> register which is implementation defined and is used for Qualcomm SoCs
>>> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch
>>> the next set of page tables accordingly allowing for faster 
>>> translations.
>>>
>>> ACTLR value is unique for each SMR (Stream matching register) and stored
>>> in a pre-populated table. This value is set to the register during
>>> context bank initialisation.
>>>
>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++++++++++++
>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++--
>>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++++
>>>   4 files changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> index ae7cae015193..68c1f4908473 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> @@ -14,6 +14,17 @@
>>>
>>>   #define QCOM_DUMMY_VAL -1
>>>
>>> +struct actlr_config {
>>> +       const struct actlr_data *adata;
>>> +       u32 size;
>>
>> This should be size_t.
>>
>> Also could you please drop the separate struct actlr_config and move
>> these two fields into struct qcom_smmu_config.
>>
> 
> Ack, will address both these inputs in the next patch.
> 

Dimitry, Tried moving both fields to qcom_smmu_config but since
actlr_data need to be a pointer to array and not scalar, size needs
to be calculated dynamically for each SoC data in a loop which is 
doable.But readily available implementations like ARRAY_SIZE cannot be 
used, so I think this extra struct indirection of actlr_config would be 
beneficial.
Some drivers like llcc (drivers/soc/qcom/llcc-qcom.c) is also using
similar implementation, I believe for the same reason.

regards,
Bibek
>>> +};
>>> +
>>> +struct actlr_data {
>>> +       u16 sid;
>>> +       u16 mask;
>>> +       u32 actlr;
>>> +};
>>> +
>>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>>   {
>>>          return container_of(smmu, struct qcom_smmu, smmu);
>>> @@ -270,6 +281,26 @@ static const struct of_device_id 
>>> qcom_smmu_client_of_match[] __maybe_unused = {
>>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>   {
>>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>> +       const struct actlr_config *actlrcfg;
>>> +       struct arm_smmu_smr *smr = smmu->smrs;
>>> +       int idx = smmu_domain->cfg.cbndx;
>>> +       int i;
>>> +       u16 id;
>>> +       u16 mask;
>>> +
>>> +       if (qsmmu->actlrcfg) {
>>> +               actlrcfg = qsmmu->actlrcfg;
>>> +               for (i = 0; i < actlrcfg->size; ++i) {
>>> +                       id = actlrcfg->adata[i].sid;
>>> +                       mask = actlrcfg->adata[i].mask;
>>> +                       if (!smr_is_subset(*smr, id, mask))
>>> +                               arm_smmu_cb_write(smmu, idx, 
>>> ARM_SMMU_CB_ACTLR,
>>> +                                               
>>> actlrcfg->adata[i].actlr);
>>> +               }
>>> +       }
>>
>> Consider extracting this to a separate function. This way you can
>> reduce 4 indentation levels into a single loop.
>>
> 
> Ack, thanks for this sugestion. Will move this entire for loop into a 
> separate function for simplicity reduced indent levels.
> 
>>> +
>>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>>
>>>          return 0;
>>> @@ -459,6 +490,9 @@ static struct arm_smmu_device 
>>> *qcom_smmu_create(struct arm_smmu_device *smmu,
>>>          qsmmu->smmu.impl = impl;
>>>          qsmmu->cfg = data->cfg;
>>>
>>> +       if (data->actlrcfg && (data->actlrcfg->size))
>>> +               qsmmu->actlrcfg = data->actlrcfg;
>>> +
>>>          return &qsmmu->smmu;
>>>   }
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> index 593910567b88..4b6862715070 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>> @@ -9,6 +9,7 @@
>>>   struct qcom_smmu {
>>>          struct arm_smmu_device smmu;
>>>          const struct qcom_smmu_config *cfg;
>>> +       const struct actlr_config *actlrcfg;
>>>          bool bypass_quirk;
>>>          u8 bypass_cbndx;
>>>          u32 stall_enabled;
>>> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
>>>   };
>>>
>>>   struct qcom_smmu_match_data {
>>> +       const struct actlr_config *actlrcfg;
>>>          const struct qcom_smmu_config *cfg;
>>>          const struct arm_smmu_impl *impl;
>>>          const struct arm_smmu_impl *adreno_impl;
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 4c79ef6f4c75..38ac1cbc799b 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -992,9 +992,10 @@ static int arm_smmu_find_sme(struct 
>>> arm_smmu_device *smmu, u16 id, u16 mask)
>>>                   * expect simply identical entries for this case, 
>>> but there's
>>>                   * no harm in accommodating the generalisation.
>>>                   */
>>> -               if ((mask & smrs[i].mask) == mask &&
>>> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
>>> +
>>> +               if (smr_is_subset(smrs[i], id, mask))
>>>                          return i;
>>> +
>>>                  /*
>>>                   * If the new entry has any other overlap with an 
>>> existing one,
>>>                   * though, then there always exists at least one 
>>> stream ID
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> index 703fd5817ec1..b1638bbc41d4 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct 
>>> arm_smmu_device *smmu, int page,
>>>                  writeq_relaxed(val, arm_smmu_page(smmu, page) + 
>>> offset);
>>>   }
>>>
>>> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id, 
>>> u16 mask)
>>> +{
>>> +       return (mask & smrs.mask) == mask && !((id ^ smrs.id) & 
>>> ~smrs.mask);
>>> +}
>>> +
>>>   #define ARM_SMMU_GR0           0
>>>   #define ARM_SMMU_GR1           1
>>>   #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
>>> -- 
>>> 2.17.1
>>>
>>
>>
