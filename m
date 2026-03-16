Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB523CF697
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680864; cv=none; b=q59qLDahWTg5IBRjTUmaeR620d+1l1kFpuo7lZ7KHAp3q52P1wHmA2eWg5GXOyZGkFShhi7H1luAY0o24zF8W9h8fEM46dRGJZdDFLnVIaCeInHtpMuJ6j+XmQGKiSpFY7gHh7+kdOltEWJU9h6O+pRVa5LIN62bE9NammQWPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680864; c=relaxed/simple;
	bh=ndSyZFZJ0iMwREzqBpvvKbaR/JlX2TVhp1ZhDsVoAMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7laBGNmTt18jSZblXwwqgR/4Asm1gty5OgxOVB+KJQziSPkuKyXXMafCATMaUP9jGm3kOQ1fVxYIeeASFyzP9zKdyKogvJArZCmp9m17yMycfGRXvf7U4+sswZ49YyIGzojFUNFXwhVjfgeszPf/7yUA0KyImhtby9fJ7EfOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+Nlgmj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KclUda/B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+Nlgmj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KclUda/B"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCX9ZQ1621677
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 17:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n1xeMoYeUM0iSmvPxnEiOO/lpTwBXAxToBC2I8g5MT0=; b=X+Nlgmj4OOaKssRg
	4e+d6j+YInLZbUUYEhBCPUFKoIM4YtGoc99GwqQ10TJmPjB/CmSuHpPwmbV7wSg+
	gmPOqgVaLk8ZRcWDLGYwb4WoBNwYGGAQu9LwjKdtBF4Vq/PP8ILX80VePosnAn9/
	VUBBXlO9VluIzXokZac37bTWrwu/A3+s3GmM9CEKFq++6YzLLn0yfllLDnndTx2S
	kyronXorVd/CLR6pMaqTIWmB5SUN5szZpHBFg6AuY1JRWB88ClPlvnATCqj73Fae
	8wnwP1NqnvRuRn/MfB0lX8kaZ0Fjrfu8XnfDTCed23SOC09MYiYYPVBbVNuAGwNZ
	/Pg+zA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyeh2g1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 17:07:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so2697502a12.3
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773680860; x=1774285660; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1xeMoYeUM0iSmvPxnEiOO/lpTwBXAxToBC2I8g5MT0=;
        b=KclUda/Bzz1AuoqSKICMzFs7KcYlqheXU+ADbfD0Zc4DroAiqrRCHO5vOMx8YTpI7g
         bYZQpFs3B/NydqIi0HWScsIhuD0DZLPjoC2hBKluJx7BULfcRYlIWtXVn1/3BbumRS2D
         Cm+kos/8e9mu7YepzH7y5h5W9IXDbBANqO5x1hZMrPMrIKhNG4Uti1UiJbz5UjaT+raz
         wVI2jcxbsjUHuTAZr9WomPqhdqBom4uVCQY2PBwSnujj1HYZGkzJzEUthEBub92hdiaa
         a/JYIxMhpJTfbcbCkMfYrw9ucfI+8w6wMxWuAW+kJspMOV08zmrRdETTHuSyR2DcZN43
         WLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680860; x=1774285660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1xeMoYeUM0iSmvPxnEiOO/lpTwBXAxToBC2I8g5MT0=;
        b=rflKXrQJkh3MDyhqrSCu2V/joa573LTGRy+8vJdB5+K7E6KE0QkW41jaTnhaaVrAUP
         MHrb5Ac2R/+Eirh6R7xWmlOZyIOIbHolE+N7LMDywb2apoRUZRioncv6hd8XhwO1xGdr
         inamA5497tg2ioUhnejiUAal9oJ1aJ0tVu45XeY/hg10UMGwK7m/+MyvmGbbjs01zhYW
         qJQL8WuEkwOIojT4j/cIsWTcDWiNKbrCmex5UvSol3G04hQHDxZ2Za/HrgWnUpFVHbXN
         H2WbD/U8blmyeqkaazmzGWDrnNgkCOqaXzX8oE9QjygdSUkb4WvAFWQHm0sNvQpU5NLc
         TtoA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdlueOfg5r0dC+rXDjZzzLzmuiPUGZ0Y+o0nTIQDxWWu+kO7MpVYwh23ub9kpDnCuwlTi3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn/ZC1E4F7LlqXRg4IuVIseS316ChQ0GJojl+XxsbVsnGxwti7
	xBqUbhfq+PG82damjOS+ct+BrJgYxSCW0JRRnA1qPWKz2nweFjJTBNAnvMznwzj+SYCwxkzMziG
	xFwpVEuZixCbTJkGXn2ykzhCzoCNH/JCBQEXKp8jsgb3/9n0pQRyh1hDviA==
X-Gm-Gg: ATEYQzxR2mutbE/48QvJ2ghDbtUjxAnTdGPvvm9QoCR9+bMS7WiujGPrOFIQBBES0jN
	1jvHYbeEpS0V9VSv5yxlNIPN49xhqNuwacOf8xDi/aMwIXCmC6LvOfFtCUdbZUH96E6k6SHZiB8
	tObmROT4kSs+xA23RR7m5rzza1vmvh4XQkXHyuD7ELwwGSzGnodDu6OjYHN2uL7/aoRWtebx8em
	NgDagagstttikZuN0ql+Ks+q4d5yaKMABmoeRnSjF6USqoJzHSkYscsxcuZVboWVuB8N4yHwXc1
	I4wpqVfUiBSW4yMzLuSXnyzYZRCPBoktbVZ5KbzoR04Ou4o0X822RI90a9CUWwZmVMCuRU5kAKi
	hM/T8/HUmU5R/bAaa7glt1BYoqChfyFW7euHWeL4Hxtk1m+/wH1fReciI9g==
X-Received: by 2002:a05:6a00:854:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-82a196d9795mr12519513b3a.11.1773680860297;
        Mon, 16 Mar 2026 10:07:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:854:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-82a196d9795mr12519484b3a.11.1773680859759;
        Mon, 16 Mar 2026 10:07:39 -0700 (PDT)
Received: from [192.168.1.12] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072418e9sm14954842b3a.3.2026.03.16.10.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:07:39 -0700 (PDT)
Message-ID: <dbfcbc9c-2175-49a3-aee4-434b69cbaece@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 22:37:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
 <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
 <27edd195-b0d3-4214-9df3-74a84da1e3e1@oss.qualcomm.com>
 <dyjdwxaq4oc7ahri3iuhnmobh3gwmn6drhox7t2elep4rlqhuq@fe4gp5t7q5r5>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <dyjdwxaq4oc7ahri3iuhnmobh3gwmn6drhox7t2elep4rlqhuq@fe4gp5t7q5r5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BtGUEhTtVBPErM-9eInkq-ywr0QLDDP-
X-Proofpoint-ORIG-GUID: BtGUEhTtVBPErM-9eInkq-ywr0QLDDP-
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b838dd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=GQrJT2J37VpXmJLvS4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX66SCw6G4hb5G
 iTk/Z7kLCLd5aahqcENpo6yrcM+XXm8wNP9QDW/zP55Tv6Vc7crM1prklUv+I5xZeiXeVDlmwW9
 SL+iewJM4Vcpb95OkXh437Omjc2B0esxbwm7+igMmxcA0KHiGPNvPf16U234+U344lNoamg9m/a
 uSNUgzlW+XXoUeuJ2Hk7CNaK1ykOaTswsYPsAyTvT4pSZ9lcNcsru3i9vD1AEGPUPYrfCqycd6h
 Yb28HVw2/D+/pUmmaUdyEWg4HM2GAyAwdCFsYzzJPXmUPK/kW9Rbes17EI6VENXGPN0Xo472IF2
 Sa+bCfUoMeWURpSuK7fZSWny5goDHSafzNKDyaGRw+UuWekEtBzqTprxhc+H54YQkN8Yy5eiBA7
 gg0hU5h5l8YGAbi3Qw5H8LVusocQgiWuTymH8+Gcr1j7QeZHIjz6OjkjbEbYAG1yN9laWCov4Ir
 lwmPzQc+HFctCd1/SEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160133



On 3/12/2026 7:48 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 12, 2026 at 05:12:51PM +0530, Vijayanand Jitta wrote:
>>
>>
>> On 3/10/2026 2:53 AM, Dmitry Baryshkov wrote:
>>> On Mon, Mar 09, 2026 at 01:03:38AM +0530, Vijayanand Jitta wrote:
>>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>>
>>>> Change of_map_id() to take a pointer to struct of_phandle_args
>>>> instead of passing target device node and translated IDs separately.
>>>> Update all callers accordingly.
>>>>
>>>> Subsequent patch will make use of the args_count field in
>>>> struct of_phandle_args.
>>>>
>>>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>>> ---
>>>>  drivers/cdx/cdx_msi.c                    |  5 ++-
>>>>  drivers/iommu/of_iommu.c                 |  2 +-
>>>>  drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
>>>>  drivers/of/base.c                        | 63 ++++++++++++++++----------------
>>>>  drivers/of/irq.c                         |  8 +++-
>>>>  drivers/pci/controller/dwc/pci-imx6.c    | 16 ++++++--
>>>>  drivers/pci/controller/pcie-apple.c      |  5 ++-
>>>>  drivers/xen/grant-dma-ops.c              |  4 +-
>>>>  include/linux/of.h                       | 12 +++---
>>>>  9 files changed, 76 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
>>>> index 63b3544ec997..03232b5ffbca 100644
>>>> --- a/drivers/cdx/cdx_msi.c
>>>> +++ b/drivers/cdx/cdx_msi.c
>>>> @@ -121,6 +121,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>>>>  			   struct device *dev,
>>>>  			   int nvec, msi_alloc_info_t *info)
>>>>  {
>>>> +	struct of_phandle_args msi_spec = { .np = NULL };
>>>
>>> Why do you need to set it? Parse functions ignore passed args, don't
>>> they?
>>>
>>
>> The parse function does check arg->np on input — if it is non-NULL,
>> it is used to match only entries targeting that specific node.
>>
>> Also, there is this existing path in drivers/pci/msi/irqdomain.c which
>> pre-sets the node and passes it as input to of_msi_xlate(), so the node
>> pointer is not ignored by the parse code:
> 
> Is it only being used for MSIs? If so, can we make that explicit in the
> API by having the 'filter' device_node pointer?
> 

Yes, I see this is used only in the MSI path via of_msi_xlate(). 

By filter do you mean the below changes ? here of_map_id() and of_map_msi_id() would accept the filter
as a separate parameter so that arg becomes a pure output:


int of_map_id(const struct device_node *np, u32 id, const char *map_name,
              const char *cells_name, const char *map_mask_name,
              const struct device_node *filter_np, struct of_phandle_args *arg);

int of_map_msi_id(const struct device_node *np, u32 id,
                  const struct device_node *filter_np, struct of_phandle_args *arg);

of_msi_xlate() would then pass *msi_np as filter_np down to of_map_msi_id
and IOMMU callers would pass NULL to of_map_id. 

Does this look fine ? I can include this in v11.

Thanks,
Vijay

>>
>> u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>> {
>>         struct device_node *of_node;
>>         u32 rid = pci_dev_id(pdev);
>>
>>         pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>>
>>         of_node = irq_domain_get_of_node(domain);
>>         rid = of_node ? of_msi_xlate(&pdev->dev, &of_node, rid) :
>>                         iort_msi_map_id(&pdev->dev, rid);
>>
>>         return rid;
>> }
>>
> 

