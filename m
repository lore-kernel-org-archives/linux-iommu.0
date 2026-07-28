Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE4381E88
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211674; cv=none; b=q99Vg9vhYfWH63oS0ZOxFAmo49adQ9aBKuQyHFVifu/fyJ908cQbx70EP7zf4fxFp9g/zZM+L2Ez/gLZNFJQzvexqtcbtYbbHA3+ybRPzdYlFRTP4loN189GJlWV1n49b0oITm5sIFGlgFB6GH1sjIj8SPbXatDNWRWG81snZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211674; c=relaxed/simple;
	bh=1viSFWqmF3URMlkL5kC01xZkVFYGhTB/K2Hjjkt63Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNDNgExPO83se7xuUib2Do6wyLojqBAdFlRkn5LUS8LkHx7QPYqz2W/mjn0DD+vSmRafTpDGtKwH1R75bn4G2s7qrbV5f0xDLHVwqoUVKnaTk9NhaNHbSZrGUELyzJrL8S/H+rV1bv0PMin5foGalxmCMFo6kJAleCy+S3JpVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFgE1xJe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uehf6/o9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFgE1xJe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uehf6/o9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3tvr81920116
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 04:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LK3y07L9JsKqzOy/FLTAxwpeW1DK6L0Aa7RC06zF1Gc=; b=FFgE1xJe6UKoNQYE
	+igk/lKKKT2gc1TXlw7wG5U2X4N88qZIopsTTXkEHMOr+nrTgOX2g8/rEBlALAJ3
	41DH2X3DseYCwgCcoo8soqHkig9SRruLONrjfJ+/uMfJFtYPcw/Ktef8FDYhnUqO
	gGaiYdzllKLuD7zATWwLnnX3kk+g6jOeQ4SLHxKWICwjmOqiYIjg8gteKs4rtP7T
	Qk8q6ck3aQIKxYjdPbnX1mg1beTunEGa9MAz4MvsiV17J4Q2O4ucKd1yg8hR/xT+
	FBRAgm/m3Wbx6m+luhxgff2BIBImaXbhJlxfSkO6Y8P0IA0qVLyLGSiW/fZ0fDI3
	Ej2kRw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy101b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 04:07:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so8449746a91.3
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785211670; x=1785816470; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK3y07L9JsKqzOy/FLTAxwpeW1DK6L0Aa7RC06zF1Gc=;
        b=Uehf6/o9Px4xMeIoA3+EAFUnVTg0y2lSIkO7w7iGoZgh0e/3M22wraEgh2gjyrrw5H
         ZXgjuh1nxEStpemu5xd1ivWQppj4T4EEHuIslhxL2vBLtEO4NlQ0MDAGQxi2f6w1XHwY
         uFqTpD+GuIDn9fvz0WbFTAj6AfmAWFR+tTsloZ2UKadA+vp70Gi75mcNFpNd+L/EKGvN
         raKsQjoA91jjlEDbKKuHOWC8hq4Kk96JiLZ2RslDT3NDbK28NQXDegRzF4XyGliI4JVO
         p+TNym9QlhZuqzrkItYKrUa6DWO6x8tTmElrbkCgTDiW3F6Ux9+jRXSSs4CSPKc5OQLr
         eSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785211670; x=1785816470;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LK3y07L9JsKqzOy/FLTAxwpeW1DK6L0Aa7RC06zF1Gc=;
        b=X3HqMC+nqJdvL9OMgZdWN/zA2m5RnnFJ9y5xox7hXEpfxMlrzirfO80O8BTBKKTaAA
         xI5FgK6NbSsoMprnKxBQhXOgN8bXVlInXPjvdBv2pKQH04l4obX3Xcy3BFYH+RQCe5o/
         Mbtgo1jtfebAZDaNpwWi7wAoFFexHpsb7tjxOJpK8bJQn7LaMOASqgmzVeB5FB+BOPd+
         EPn5wcKujwc8vEKZhrdh/i4sAA+Dcg3yn3YeWwhdskN4lvQnmyI5YA8Lozsj/i6BaJD4
         URogEK5EhaQYc9q1Tb+cJAHVLf66V/4JexGUe0r8Kg0Z0UK8THng8MS8JBHeuMS49iSX
         fqIw==
X-Forwarded-Encrypted: i=1; AHgh+Rrl0QmosQsaYQ5jim4JWZkmI2KrHjaZ/1G0BWhegmJyp7HdKMf4rDOEjkNScSkFP1msgqdnAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+cJBx/OCFl8QWezmcIyB40xbKRCqOzzEWRpoGZfIINCjyYUM0
	B0ACOjy9H71hSSJlU96FVRoGik/ygPttS/rcwILRkaubISai3PTxVwcL5XOl0X/0nKbTLbn6ZAK
	kCUbMXuiURbIGSBwNoVkgwMsBYoVYRV6uonnHuFwEeJ5rtbTeHk7Nz2Sb6Q==
X-Gm-Gg: AR+sD12j9OluxjpAsjTHeAFg5l8FVODIjCBexJasIafkycdcwO4pVrzH/ixSgU9W1Ux
	TI9noFZkCnVaIOSEB3KMynXVXlXp3s3IR9HMBe9tlZSws0CbYsRvb7uGZ0ke6X56SJ0wnMhXym+
	Hl0bn/P3DCjKUZZk9XAdksF8HCPwodgsHG4FLbwtvpi6ri6b4u6PnjL9lrIiaCQdzLuTwuxFNWs
	mgV7mzQg+W8ooiOHka7JHnS4Cb7QHSM0EIMu+YOjhjXlgFChEV/wrOCyZXa6py8UQ6EV7S7nIHK
	SIVFEAeRzPy9vj3hqheIul7NiQDbMGj+iRIuUBZr8lpZIaLXtIz0WNTY0WAmS+6vyw17hn4T2Dw
	QR2FrpVxSQ6pOgJQcVZFtkXQ6cdFS9GAouuH6
X-Received: by 2002:a05:6a20:6a15:b0:3c4:1708:9cd8 with SMTP id adf61e73a8af0-3c8ba6862bbmr1003939637.76.1785211669607;
        Mon, 27 Jul 2026 21:07:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a15:b0:3c4:1708:9cd8 with SMTP id adf61e73a8af0-3c8ba6862bbmr1003878637.76.1785211668977;
        Mon, 27 Jul 2026 21:07:48 -0700 (PDT)
Received: from [192.168.1.14] ([103.28.245.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm62422249eec.2.2026.07.27.21.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 21:07:48 -0700 (PDT)
Message-ID: <0d0896af-a4a5-445d-8db7-fdb9eecd07a2@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 09:35:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
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
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
 <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LIobmVcN35MTIof2zSD3OKMLa0VRhqhe
X-Proofpoint-ORIG-GUID: LIobmVcN35MTIof2zSD3OKMLa0VRhqhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAzNCBTYWx0ZWRfXzLqGIsuRs2rX
 XpQBdrVFO+PyBAPO+hYUFyG2rypHCfjnZL6jmazt93jcGKwiGy3Z8NQpD2lxVLtdq7AIO6c50C0
 oWBRgjk8pipfe6tn1hNmRj4rod66hDud4VX0eEF4tD8xI3dG2r3pKYOU6OB6qtVKvYPV6ge8KWF
 K9ymEkSA1CkP+7CaPLkpOMpDUBZm/oXW5ger3MlLOhfzEpRJ4Ai+/W2t1kj0WeWU8kLLtRJJQBj
 oUO1mqRiezEjsPFTjlPbHczmujh/S7oDfUZdQv2cAJkky57kn0VSLgorvvEbL9cTu+azIXhXHst
 BgD7HQlVzl7WzOOq5q1f5EtuCEohPAb3p5FuVVuHlC4nYmcZkA7X0rJNHiEGNbpWEGbfV4OmTCs
 F+25bCUTDn/4sVs5b72KLxMT6Qwg+QIkKGlHEAiziji//GwcGvWkyyLPQz3yjyY4MO2rU2UG/+v
 rFV5l+p16nue7WYnFxw==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a682b16 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=squdMJ+4YbgyfOnWmi5+Dg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=q5R4RTgJWa76_yJtbd4A:9
 a=8pEowBHnLtz2IKIQ:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAzNCBTYWx0ZWRfX5SoOSypoOZ45
 ZfXHoZMsPz/TVlSaTTTnSlghF/c6K8z50vqIJ7IfvW5E8wKHM3rhZWb3crbU4/yTvNWsJ+cJiWd
 aU+cUVsZ1PGt7eF+873US5L8f+DJYuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280034



On 7/23/2026 6:47 PM, Neil Armstrong wrote:
> Hi,
> 
> On 6/3/26 09:13, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properties has always blindly
>> assumed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use in being able to map at least single
>> input IDs to multi-cell output specifiers (and properly support 0-cell
>> outputs as well), add support for properly parsing and using the target
>> nodes' #cells values, albeit with the unfortunate complication of still
>> having to work around expectations of the old behaviour too.
>>
>> Since there are multi-cell output specifiers, the callers of of_map_id()
>> may need to get the exact cell output value for further processing.
>> Update of_map_id() to set args_count in the output to reflect the actual
>> number of output specifier cells.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>   drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
>>   include/linux/of.h |   6 +-
>>   2 files changed, 135 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index d658c2620135..ac7961cbab94 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
>>       return cache_level;
>>   }
>>   +/*
>> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
>> + * specifying only 1 cell. Fortunately they all consist of value '1'
>> + * as the 2nd cell entry with the same target, so check for that pattern.
>> + *
>> + * Example:
>> + *    IOMMU node:
>> + *        #iommu-cells = <2>;
>> + *
>> + *    Device node:
>> + *        iommu-map = <0x0000 &smmu 0x0000 0x1>,
>> + *                <0x0100 &smmu 0x0100 0x1>;
> 
> So the sm8650 PCIe controllers has:
> 
> pcie@1c08000:
>             iommu-map = <0     &apps_smmu 0x1480 0x1>,
>                     <0x100 &apps_smmu 0x1481 0x1>;
> 
> and
> 
> pcie@1c00000:
> 
>             iommu-map = <0     &apps_smmu 0x1400 0x1>,
>                     <0x100 &apps_smmu 0x1401 0x1>;
> 
> and apps_smmu has #iommu-cells = <2>, but gets flagged at wrong:
> 
> [    7.538800] OF: /soc@0/pcie@1c08000: iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output
> 
> Returning false in of_check_bad_map() triggers:
> 
> [    7.642680] OF: /soc@0/pcie@1c08000: Unsupported iommu-map - cannot handle 256-ID range with 2-cell output specifier
> 
> I don't understand the issue here, we use 2 cells as expected by
> the iommu-cells, so why is it wrong ? can somebody explain in
> comprehensive words ? I'm super confused, it worked like a charm until now.
> 
> Neil
> 

Hi Neil,

iommu-map = <0     &apps_smmu 0x1480 0x1>,
            <0x100 &apps_smmu 0x1481 0x1>;


Entries here are not 2-cell format, Even though apps_smmu declares #iommu-cells = <2>,
this DT only supplies one output cell (0x1480/0x1481) — the trailing 0x1 is the length field,
not a second output cell. (<id-base phandle out-base length>)

The new code detects exactly this pattern (same target phandle across all entries, length always 1)
and falls back to treating the map as 1-cell output for backward compatibility — hence the pr_warn_once.
It's harmless and expected, your RIDs still resolve to the correct SIDs (0 → 0x1480, 0x100 → 0x1481).

The second message is a different case and shouldn't be coming from this same map — once the 1-cell
fallback triggers on the first entry, it applies to the whole map, so you shouldn't hit both warnings
together on the same node. That error only fires for a genuine 2-cell output specifier combined with
an id_len > 1, e.g.:

iommu-map = <0x0 &apps_smmu 0x1480 0x1 0x100>;

(<id-base, phandle, out0, out1, length=256>) — which isn't supported, since there's no way to
linearly scale a multi-cell output specifier across a range of IDs.

Are you seeing that second error on the same pcie node, or a different one?
If it's the same node, can you share the exact iommu-map entry that triggers it?


Thanks,
Vijay

>> + */
>> +static bool of_check_bad_map(const __be32 *map, int len)
>> +{
>> +    __be32 phandle = map[1];
>> +
>> +    if (len % 4)
>> +        return false;
>> +    for (int i = 0; i < len; i += 4) {
>> +        if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
>> +            return false;
>> +    }
>> +    return true;
>> +}
>> +
>>   /**
>>    * of_map_id - Translate an ID through a downstream mapping.
>>    * @np: root complex device node.
>>    * @id: device ID to map.
>>    * @map_name: property name of the map to use.
>> + * @cells_name: property name of target specifier cells.
>>    * @map_mask_name: optional property name of the mask to use.
>>    * @filter_np: pointer to an optional filter node, or NULL to allow bypass.
>>    *    If non-NULL, the map property must exist (-ENODEV if absent). If
>>    *    *filter_np is also non-NULL, only entries targeting that node match.
>>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
>> - *    @arg->args[0] will contain the translated ID. If a map entry was
>> - *    matched, @arg->np will be set to the target node with a reference
>> - *    held that the caller must release with of_node_put().
>> + *    @arg->args_count will be set to the number of output specifier cells
>> + *    as defined by @cells_name in the target node, and
>> + *    @arg->args[0..args_count-1] will contain the translated output
>> + *    specifier values. If a map entry was matched, @arg->np will be set
>> + *    to the target node with a reference held that the caller must release
>> + *    with of_node_put().
>>    *
>>    * Given a device ID, look up the appropriate implementation-defined
>>    * platform ID and/or the target device which receives transactions on that
>> @@ -2137,19 +2167,21 @@ int of_find_last_cache_level(unsigned int cpu)
>>    * Return: 0 on success or a standard error code on failure.
>>    */
>>   int of_map_id(const struct device_node *np, u32 id,
>> -           const char *map_name, const char *map_mask_name,
>> +           const char *map_name, const char *cells_name,
>> +           const char *map_mask_name,
>>              struct device_node * const *filter_np, struct of_phandle_args *arg)
>>   {
>>       u32 map_mask, masked_id;
>> -    int map_len;
>> +    int map_bytes, map_len, offset = 0;
>> +    bool bad_map = false;
>>       const __be32 *map = NULL;
>>   -    if (!np || !map_name || !arg)
>> +    if (!np || !map_name || !cells_name || !arg)
>>           return -EINVAL;
>>       /* Ensure bypass/no-match success never returns a stale target node. */
>>       arg->np = NULL;
>>   -    map = of_get_property(np, map_name, &map_len);
>> +    map = of_get_property(np, map_name, &map_bytes);
>>       if (!map) {
>>           if (filter_np)
>>               return -ENODEV;
>> @@ -2159,11 +2191,9 @@ int of_map_id(const struct device_node *np, u32 id,
>>           return 0;
>>       }
>>   -    if (!map_len || map_len % (4 * sizeof(*map))) {
>> -        pr_err("%pOF: Error: Bad %s length: %d\n", np,
>> -            map_name, map_len);
>> -        return -EINVAL;
>> -    }
>> +    if (map_bytes % sizeof(*map))
>> +        goto err_map_len;
>> +    map_len = map_bytes / sizeof(*map);
>>         /* The default is to select all bits. */
>>       map_mask = 0xffffffff;
>> @@ -2176,39 +2206,93 @@ int of_map_id(const struct device_node *np, u32 id,
>>           of_property_read_u32(np, map_mask_name, &map_mask);
>>         masked_id = map_mask & id;
>> -    for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
>> +
>> +    while (offset < map_len) {
>>           struct device_node *phandle_node;
>> -        u32 id_base = be32_to_cpup(map + 0);
>> -        u32 phandle = be32_to_cpup(map + 1);
>> -        u32 out_base = be32_to_cpup(map + 2);
>> -        u32 id_len = be32_to_cpup(map + 3);
>> +        u32 id_base, phandle, id_len, id_off, cells = 0;
>> +        const __be32 *out_base;
>> +
>> +        if (map_len - offset < 2)
>> +            goto err_map_len;
>> +
>> +        id_base = be32_to_cpup(map + offset);
>>             if (id_base & ~map_mask) {
>> -            pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
>> -                np, map_name, map_name,
>> -                map_mask, id_base);
>> +            pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
>> +                   np, map_name, map_mask_name, map_mask, id_base);
>>               return -EFAULT;
>>           }
>>   -        if (masked_id < id_base || masked_id >= id_base + id_len)
>> -            continue;
>> -
>> +        phandle = be32_to_cpup(map + offset + 1);
>>           phandle_node = of_find_node_by_phandle(phandle);
>>           if (!phandle_node)
>>               return -ENODEV;
>>   +        /*
>> +         * Assume 1-cell output specifier if the target node lacks the
>> +         * #cells property, for backward compatibility with controllers
>> +         * that predate the property (e.g. arm,gic-v2m-frame).
>> +         */
>> +        if (bad_map || of_property_read_u32(phandle_node, cells_name, &cells))
>> +            cells = 1;
>> +
>> +        if (cells > MAX_PHANDLE_ARGS) {
>> +            pr_err("%pOF: %s cell count %d exceeds maximum\n",
>> +                   phandle_node, cells_name, cells);
>> +            of_node_put(phandle_node);
>> +            return -EINVAL;
>> +        }
>> +
>> +        if (offset == 0 && cells == 2) {
>> +            bad_map = of_check_bad_map(map, map_len);
>> +            if (bad_map) {
>> +                pr_warn_once("%pOF: %s has 1-cell entries targeting 2-cell %s, treating as 1-cell output\n",
>> +                         np, map_name, cells_name);
>> +                cells = 1;
>> +            }
>> +        }
>> +
>> +        if (map_len - offset < 3 + cells) {
>> +            of_node_put(phandle_node);
>> +            goto err_map_len;
>> +        }
>> +
>> +        out_base = map + offset + 2;
>> +        offset += 3 + cells;
>> +
>> +        id_len = be32_to_cpup(map + offset - 1);
>> +        id_off = masked_id - id_base;
>> +        if (masked_id < id_base || id_off >= id_len) {
>> +            of_node_put(phandle_node);
>> +            continue;
>> +        }
>> +        if (id_len > 1 && cells > 1) {
>> +            /*
>> +             * With 1 output cell we reasonably assume its value
>> +             * has a linear relationship to the input; with more,
>> +             * we'd need help from the provider to know what to do.
>> +             */
>> +            pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
>> +                   np, map_name, id_len, cells);
>> +            of_node_put(phandle_node);
>> +            return -EINVAL;
>> +        }
>> +
>>           if (filter_np && *filter_np && *filter_np != phandle_node) {
>>               of_node_put(phandle_node);
>>               continue;
>>           }
>>             arg->np = phandle_node;
>> -        arg->args[0] = masked_id - id_base + out_base;
>> -        arg->args_count = 1;
>> +        for (int i = 0; i < cells; i++)
>> +            arg->args[i] = id_off + be32_to_cpu(out_base[i]);
>> +        arg->args_count = cells;
>>             pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>> -            np, map_name, map_mask, id_base, out_base,
>> -            id_len, id, masked_id - id_base + out_base);
>> +            np, map_name, map_mask, id_base,
>> +            cells ? be32_to_cpup(out_base) : 0,
>> +            id_len, id,
>> +            cells ? id_off + be32_to_cpup(out_base) : id_off);
>>           return 0;
>>       }
>>   @@ -2219,6 +2303,10 @@ int of_map_id(const struct device_node *np, u32 id,
>>       arg->args[0] = id;
>>       arg->args_count = 1;
>>       return 0;
>> +
>> +err_map_len:
>> +    pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
>> +    return -EINVAL;
>>   }
>>   EXPORT_SYMBOL_GPL(of_map_id);
>>   @@ -2228,18 +2316,21 @@ EXPORT_SYMBOL_GPL(of_map_id);
>>    * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
>>    *      stream/device ID) used as the lookup key in the iommu-map table.
>>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
>> - *    @arg->args[0] contains the translated ID. If a map entry was matched,
>> - *    @arg->np holds a reference to the target node that the caller must
>> - *    release with of_node_put().
>> + *    @arg->args_count will be set to the number of output specifier cells
>> + *    and @arg->args[0..args_count-1] will contain the translated output
>> + *    specifier values. If a map entry was matched, @arg->np holds a
>> + *    reference to the target node that the caller must release with
>> + *    of_node_put().
>>    *
>> - * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
>> + * Convenience wrapper around of_map_id() using "iommu-map", "#iommu-cells",
>> + * and "iommu-map-mask".
>>    *
>>    * Return: 0 on success or a standard error code on failure.
>>    */
>>   int of_map_iommu_id(const struct device_node *np, u32 id,
>>               struct of_phandle_args *arg)
>>   {
>> -    return of_map_id(np, id, "iommu-map", "iommu-map-mask", NULL, arg);
>> +    return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", NULL, arg);
>>   }
>>   EXPORT_SYMBOL_GPL(of_map_iommu_id);
>>   @@ -2252,17 +2343,20 @@ EXPORT_SYMBOL_GPL(of_map_iommu_id);
>>    *    If non-NULL, the map property must exist (-ENODEV if absent). If
>>    *    *filter_np is also non-NULL, only entries targeting that node match.
>>    * @arg: pointer to a &struct of_phandle_args for the result. On success,
>> - *    @arg->args[0] contains the translated ID. If a map entry was matched,
>> - *    @arg->np holds a reference to the target node that the caller must
>> - *    release with of_node_put().
>> + *    @arg->args_count will be set to the number of output specifier cells
>> + *    and @arg->args[0..args_count-1] will contain the translated output
>> + *    specifier values. If a map entry was matched, @arg->np holds a
>> + *    reference to the target node that the caller must release with
>> + *    of_node_put().
>>    *
>> - * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
>> + * Convenience wrapper around of_map_id() using "msi-map", "#msi-cells",
>> + * and "msi-map-mask".
>>    *
>>    * Return: 0 on success or a standard error code on failure.
>>    */
>>   int of_map_msi_id(const struct device_node *np, u32 id,
>>             struct device_node * const *filter_np, struct of_phandle_args *arg)
>>   {
>> -    return of_map_id(np, id, "msi-map", "msi-map-mask", filter_np, arg);
>> +    return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", filter_np, arg);
>>   }
>>   EXPORT_SYMBOL_GPL(of_map_msi_id);
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index ea50b45d9ff7..374b249766a2 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -465,7 +465,8 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
>>   bool of_console_check(const struct device_node *dn, char *name, int index);
>>     int of_map_id(const struct device_node *np, u32 id,
>> -           const char *map_name, const char *map_mask_name,
>> +           const char *map_name, const char *cells_name,
>> +           const char *map_mask_name,
>>              struct device_node * const *filter_np,
>>              struct of_phandle_args *arg);
>>   @@ -950,7 +951,8 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>>   }
>>     static inline int of_map_id(const struct device_node *np, u32 id,
>> -                 const char *map_name, const char *map_mask_name,
>> +                 const char *map_name, const char *cells_name,
>> +                 const char *map_mask_name,
>>                    struct device_node * const *filter_np,
>>                    struct of_phandle_args *arg)
>>   {
>>
> 

