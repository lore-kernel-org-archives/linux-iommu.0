Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F52BEC31
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959258; cv=none; b=YD/uiHA/EkbxszsyV3T1qnGQSIsWbXx7TGSFjIuF4U8K3jp58fXHS+yuZSHQwwUVCdKLmeTdbU9B1kBQX+f2oaUv/Z94CYcoJYIWf0GA6XzahtqKzEBnyjWJh8XulKK/Cqa1z8aGr2DIKIaB6HpN2e2cXU7J98N8/oOZ1RVKR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959258; c=relaxed/simple;
	bh=JNvsFizY3MZpCA2nyAGk6pFUcN6eigTweheTrtNYaUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BMXWA8WVU1HJWSz4nPZ33xXzPKjNy0eQ5jVij/T19mBx+CN/IDOAulRPn3OxcM9BNg0sxhU8I1eKcNNb7h8Ic2eDtiJY9pOzntMVqCSWebMmxDAG5RVEFL3Cpn0U3o1Y3imTog/ID19YBSZ/V/EMSXP5E/1/NPmOTfRSmNv2u8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E8G7q+lh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ECKXCsRY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8G7q+lh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ECKXCsRY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEJ6v91382143
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tnODs1d9LFymSlc6N0kRGMUQOxfNS2qGq5bDsTGExY=; b=E8G7q+lh6Hyc+8AP
	lCr6A8RWZej+5L8en86kMtLxZadCewi8KXVgVXUvqWeiTbCE36rIZRaLdwKcGMAF
	23uBirbC6kp1Ixgim8lhjaSOwe6ymJModFum/hgoj/GgYPYmm+h+MZecN7pYpJxd
	Re3fb1COlOjtIV8VZy9+jqQ5QnJhRbcb1TwTwenSX13yHGYciIjOMcbuesAOIx+I
	bP2vRPG9WZjWeEVK+2cvryVEwIuh8vqfU698daY5K1TTV9j2BM5VtpnNICEJjQeV
	khg23C9zs7kUJWqjEUVM3DFMGJuGp+PK3RmGHvJ5lWKXkRCStTxe0b2oOxNyiJBM
	Ftc8AA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw483c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882381f2092so45927236d6.1
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762959254; x=1763564054; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tnODs1d9LFymSlc6N0kRGMUQOxfNS2qGq5bDsTGExY=;
        b=ECKXCsRYlqhIYdxEKOPWepzagW7djPcJp5JK7odXTmtV1pefgBs4kRnM864d8OKV1g
         XXXC4njryNnyM+09C1BwF3id1TGaW5FBudxAOUEvxkftUuEauDtN8F6pq047maRe8alJ
         V7/Ah/KMLtbmhqf4FYPf8NjsTDTnszB01WsQ6XOVCa0M9cO8wvXgsimFijg6AorHJRDA
         Svzp0xIN9Z9vXDMLFiZYiZMa5koPkISQFycc9zpWbsgDM0M+ic+mfV4cXzEZSp76CdLG
         DoXweae2qA7HL3F+GmZ1RMaCreQGaEjx4mAihXMQRxfiulD7sYQo3KY+6jrutPQ35O4v
         umUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959254; x=1763564054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tnODs1d9LFymSlc6N0kRGMUQOxfNS2qGq5bDsTGExY=;
        b=xKLI/sPMfaMaWpskGezt7YXBN7q8BaYi9kn6gAEEF9mWSOJPJ/RFoj9sP51RLZ7WCD
         EKfEexZrbwHfmwtPTbTTBw8ge/zjUQV7rqAPEr5xzPrQ7ougtMkNeHpT4QHM2KcIlXcD
         ZQ1/NZhLX0fzD+ZSwEo1TJAW43LKV7hd1ZTEOYcLhO1+xZ5A64NsDtLp5+x4BtJQ8AgB
         Lo1FFxlvRWY8Ua6MPmIDU5hhclVLFfPYp+GWGpwULnfiQ77iXEikMbfg0+qpOoIwsaax
         n4ITEfZ+/BB4YrvPgLzEWridB6e61CXt6fFpd3y+CaO2faUsgQhvqNEKapXdVj9QdxMV
         ltsA==
X-Gm-Message-State: AOJu0YxkRvh+OtdpdqGpO4UAIsAh6ul0CxPRmUSFhSSnMQkJDAbIeS1/
	8GzEmZOHexr3zXYyOjSzw5Q5DllXTVDBnR7e6c41uTMg88y3RpdEGatyeZgOk5cc8Aa7uHUw11d
	NpJa+TB6FWfCY6Z3OQ5GXjMcHeNRr6ZyxTkhr6afG2crx1BljNoUJb183sQ==
X-Gm-Gg: ASbGncvsUnbmvUR8W1oHP5GdMczBuQciMcj0zLMLFtQa/E22B1yTZS/JH7jomL0GC/j
	nVZXUQeETZpx043MfCYdhXiEOY8OAc9uAmJAk1QKfrBMZJul+YjBbNvxbqsjWIKSt7AK8/A7e1U
	IDUDxaf2DvlA7KQx4bHK/18i2HzbRt4x3agYkiW+pEelCmwaPTMLs+PGOlM0jga+j+cJDR0LUv7
	Imil2wvw+4j74N2wpYrd0tTOiMrt8ebA6VthSko+EWL0903uBqZu6+TDPCvVBfwI9O4/j0UO90y
	MFaPdeIEUZrU7CSj3DyetR1iP+CkSzRWnJOQsVkGUU0vjtyBk3jIn4/2WxqBHL/1pWPt+RQmk2L
	Y7yK3PRchLtj+A7qFwep183xO41U=
X-Received: by 2002:a17:902:ccd2:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2984edcaa69mr44053865ad.47.1762958555569;
        Wed, 12 Nov 2025 06:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnRu/8L2E2I3TSlvSsifQNi8w8Z2UkdqLn3O54nawJzvrbUH6m7mruQK5xY3hObWotHNCEyA==
X-Received: by 2002:a17:902:ccd2:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2984edcaa69mr44053465ad.47.1762958554914;
        Wed, 12 Nov 2025 06:42:34 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf10c9sm33112355ad.38.2025.11.12.06.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:42:34 -0800 (PST)
Message-ID: <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 20:12:28 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
        robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <0319bdf5-0a46-40fc-93f8-30d74cf6475a@arm.com>
 <351373ed-c699-4945-a978-cb35412918bc@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <351373ed-c699-4945-a978-cb35412918bc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tm02D218WoRLVq7pb32MFT7I4WGdJ8Rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMCBTYWx0ZWRfX3d5u8Huo2iBG
 cuMIVyg3Eywaj/VEUSXBn5BuVT+V47jUj6LcGzTEWg0gBHrVjXUSFl/o9YGdDO63Nrr4syQGKv1
 w8LFKfGmeEyev8VSyCzpXPlMRR1ujw8aJpWvsT4kAfPImFM8QxfJafo4gWy6IKT10DsPWHwCEAs
 ULRYs1OQNYl5mG72NFTpWD9MyCx4Wd+Or7QHuM34TmQ9a6XXsc5IgSlBDMrPno/iGYntxrT6yf5
 MHwxurL6Pt3EKloC2VoZOOmDjjPYuI0X41RP1cv0ujxdCPh0REXxL9iVSKYkboAzJqsBQU6tHXP
 9AM67jPyssujAMt1lpW899FYGOZ2+EVIErauOXzcsY9O4Q7RdjzTJL0+SKjWLAfpvHaJssNpTMP
 2Q526an7LjH+keZhc2ycPy+Q2bu5yA==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=69149f97 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FAcyvArZwKh3dYUP61QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tm02D218WoRLVq7pb32MFT7I4WGdJ8Rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120120



On 11/11/2025 11:57 PM, Charan Teja Kalla wrote:
> 
> On 11/5/2025 10:58 PM, Robin Murphy wrote:
>>> The other motivation for this patchset is the below usecase.
>>> USECASE [1]:
>>> ------------
>>> Video IP, 32bit, have 2 hardware sub blocks(or can be called as
>>> functions) called as pixel and nonpixel blocks, that does decode and
>>> encode of the video stream. These logical blocks are configured to
>>> generate different stream IDs.
>>>
>>> With the classical approach of representing all sids with iommus= end up
>>> in using a single translation context limited to the 4GB. There are
>>> video usecases which needs larger IOVA space, like higher concurrent
>>> video sessions(eg: 32 session and 192MB per session) where 4GB of IOVA
>>> is not sufficient.
>>>
>>> For this case, each functionality is represented in the firmware(device
>>> tree) by the 'rid' field of the iommu-map property and the video driver
>>> creates sub platform devices for each of this functionality and call
>>> into IOMMU configuration. Each rid(function id) in the dt property
>>> indicates the bit that can be associated by the driver passed input id.
>>>
>>> Example:
>>> iommu {
>>>     #iommu-cells = 2;
>>> };
>>>
>>> video-codec@foobar {
>>>     compatible = "qcom,video";
>>>     iommus = <&apps_smmu 0x1234 0xca>;
>>>     iommu-map= <0x1 &iommu 0x1940 0x0 0x1>,
>>>                 <0x1 &iommu 0x1941 0x0 0x1>,
>>>                 <0x2 &iommu 0x1942 0x0 0x1>,
>>>                 <0x4 &iommu 0x1943 0x0 0x1>,
>>>                 <0x4 &iommu 0x1944 0x0 0x1>;
>>> };
>>>
>>> video-driver:
>>> #define PIXEL_FUNC       (1)
>>> #define NON_PIXEL_FUNC       (2)
>>> #define SECURE_FUNC       (4)
>>>
>>> case1: All these functionalities requires individual contexts.
>>> Create 3 subdevices for each of this function and call
>>> of_dma_configure_id(..,id), id = 0x1, 0x2, 0x4.
>>>
>>> Case2: Secure and non-secure functionalities require individual
>>> contexts. Create 2 subdevices and call of_dma_configure_id(..,id), id =
>>> 0x3(bitmap of pixel and non-pixel), 0x4 (secure).
>>>
>>> Credits: to Dmitry for thorough discussions on the RFC patch and major
>>> help in getting the consenus on this approach, to Konrad & Bjorn for
>>> offline discussions and reviews, to Robin for his inputs on IOMMU front,
>>> to Bod, Rob and Krzysztof for all valuable inputs.
>>>
>>> [1] https://lore.kernel.org/all/20250627-video_cb-
>>> v3-0-51e18c0ffbce@quicinc.com/
>>> [2] https://lore.kernel.org/all/20250928171718.436440-1-
>>> charan.kalla@oss.qualcomm.com/#r
>>>
>>> Charan Teja Kalla (6):
>>>    of: create a wrapper for of_map_id()
>>>    of: introduce wrapper function to query the cell count
>>>    of: parse #<name>-cells property to get the cell count
>>>    of: detect and handle legacy iommu-map parsing
>>>    of: add infra to parse iommu-map per IOMMU cell count
>>>    of: use correct iommu-map parsing logic from of_iommu layer
>>>
>>>   drivers/iommu/of_iommu.c |  59 +++++++--
>>>   drivers/of/base.c        | 269 +++++++++++++++++++++++++++++++++++----
>>>   include/linux/of.h       |  19 +++
>>>   3 files changed, 314 insertions(+), 33 deletions(-)
>> Hmm, I did actually have a quick go at this the other week too, and
>> while I though it was a bit clunky, it was still significantly simpler
>> than this seems to be...
>>
>> FWIW: https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu-map - I
> Thanks a lot Robin for taking a look and sorry for the delayed reply as
> I was on vacation.
> 
> stripped code_snippet from your patch:
> 	offset = 0;
> 	out_base = map + offset + 2;
> 	id_off = masked_id - id_base;
> 	if (masked_id < id_base || id_off >= id_len)
> 		continue;
> 	for (int i = 0; id_out && i < cells; i++)
> 		id_out[i] = id_off + be32_to_cpu(out_base[i]);
> 
> 
> seems way cleaner than mine...
> 
> Actually, we also have a case of a device emitting 2 distinct
> identifiers, eg: a device is emitting 0x1940, 0x1944 and 0x1A20 sids and
> attached to a single context bank. If I use mask to cover all these sids
> in a single iommu-map entry, it does overlap with other device SID.
> 
> I don't think that patch you shared can be used to cover the above, or
> it is?
> 
> Hence I resorted to the approach where RID used as the bitmap of indices
> to cover such cases for platform devices, which it seems you clearly
> didn't like....otherwise, any otherway we can handle such cases?

Hi Robin,

Don't want to bother you with my ideas, but I can't think of other ways 
to handle such cases of multi-map than the below. I just tried this code on 
Qemu on top of your patches(with some nit compilation fixes) and just checked
if devices are added to the iommu groups.

----------------------8888---------------------------------------------

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a511ecf21fcd..ac005e70de7d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
+#include <linux/platform_device.h>
 
 #include "iommu-priv.h"
 
@@ -41,6 +42,18 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
+static int of_iommu_configure_cb(void *arg, u32 *id_out)
+{
+	struct of_phandle_args *iommu_spec =
+		(struct of_phandle_args *)((void *)id_out - offsetof(struct of_phandle_args, args));
+	struct device *dev = arg;
+	int err;
+
+	err = of_iommu_xlate(dev, iommu_spec);
+	of_node_put(iommu_spec->np);
+	return err;
+}
+
 static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
@@ -48,12 +61,10 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args,
+			dev_is_platform(dev) ? true : false, dev, of_iommu_configure_cb);
- 	if (err)
- 		return err;
-
-	err = of_iommu_xlate(dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
 	return err;
 }
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index a4fd4a4f720b..8abe36c17309 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2085,16 +2085,21 @@ static bool of_check_bad_map(const __be32 *map, int len)
  */
 int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 	      const char *cells_name, const char *map_mask_name,
-	      struct device_node **target, u32 *id_out)
+	      struct device_node **target, u32 *id_out, bool multi_map,
+	      void *arg, of_map_id_cb cb)
 {
 	u32 map_mask, masked_id;
 	int map_bytes, map_len, offset = 0;
 	bool bad_map = false;
 	const __be32 *map = NULL;
+	bool mapped_multi_id = false;
 
 	if (!np || !map_name || !cells_name || (!target && !id_out))
 		return -EINVAL;
 
+	if (multi_map && !cb)
+		return -EINVAL;
+
 	map = of_get_property(np, map_name, &map_bytes);
 	if (!map) {
 		if (target)
@@ -2189,16 +2194,29 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
 			id_len, id, id_off + be32_to_cpup(out_base));
-		return 0;
+
+		if (multi_map) {
+			if (cb(arg, id_out))
+				return -EINVAL;
+
+			mapped_multi_id = true;
+			continue;
+		}
+
+		goto translated;
 	}
 
+	if (mapped_multi_id)
+		return 0;
+
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
 		id, target && *target ? *target : NULL);
 
 	/* Bypasses translation */
 	if (id_out)
 		*id_out = id;
-	return 0;
+translated:
+	return cb ? cb(arg, id_out) : 0;
 
 err_map_len:
 	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
diff --git a/include/linux/of.h b/include/linux/of.h
index 183be897b088..84a24c2a1041 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -24,6 +24,7 @@
 
 typedef u32 phandle;
 typedef u32 ihandle;
+typedef int (*of_map_id_cb)(void *arg, u32 *id_out);
 
 struct property {
 	char	*name;
@@ -458,7 +459,8 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
 
 int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 	      const char *cells_name, const char *map_mask_name,
-	      struct device_node **target, u32 *id_out);
+	      struct device_node **target, u32 *id_out,
+	      bool multi_map, void *arg, of_map_id_cb cb);
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
@@ -1436,17 +1438,18 @@ static inline int of_property_read_s32(const struct device_node *np,
 }
 
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
-				  struct device_node **target, u32 *id_out)
+				  struct device_node **target, u32 *id_out,
+				  bool multi_map, void *arg, of_map_id_cb cb)
 {
 	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask",
-			 target, id_out);
+			 target, id_out, multi_map, arg, cb);
 }
 
 static inline int of_map_msi_id(const struct device_node *np, u32 id,
 				struct device_node **target, u32 *id_out)
 {
 	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask",
-			 target, id_out);
+			 target, id_out, false, NULL, NULL);
 }
 
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			
-----------------------------------------------------------------------

full patch is at: https://github.com/charan-kalla-oss/linux-next/commits/refs/for/iommu_map

Thanks,
Charan
