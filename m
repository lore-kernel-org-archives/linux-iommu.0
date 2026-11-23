Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462955;
	b=m0Yi73UGCPprTcOlkRa0J26fNNdNc5D31tv2t2solIUvu8bVgEh1uMsWYGI73+nNPIs9
	 nlgDHzXFL0WNJEw0rez9q/Rp/JYVHYfYklk0ht72hL7J3bePfO1CBgsgQ/o9ZQ7J8vSXh
	 0dxG4Yt0HQI+mN6197JSdwh+AIW/navjkmC6dhXIdO5/PPvoW3Ik9Kg05yNn0Gog175jY
	 Da0qgq4W7vm1Ve7AxXV/PnZp9dgZpmmtttEXxfV7bra7gvx+i2fa/kSshi/4/84u/t6Fk
	 jgqFPD4oggxo0r/nsQxzG+FQAPp04uluKM1dQIo0LLFilz/o449uen7KIzfOXqqWJvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FcFkDguCD/ilInffZmCjUgAcHpkPgkVvkAaNeAEJ7sU=;
	b=RSlhg5+AEtZdpu6286yLkkryFAJ5V+easHIfp184xBvTw/ICQY7+dGedcLgljZmAHm5S
	 hkyz6G+FKYPuc2nD5Ytt7MTOjzQH+PEupfuz8KZnWDWHJFHlM+TzJSNU2XFYcLsindbLb
	 YesJSLQIF2z3eTWoTlmJvmHv8iS8zhQUlvEVVdE60fpNAruG9GyJYZQz+HTR0609oEnRD
	 z+X2ndq4yH3FVT9ACOiIrga1OKJM7pjBMd6MbEO0Kk0+NjphK/fmoCaAGJxCFlquSnYps
	 V7h5MDaBiccK3pXKL4fnukIl3CJignplUXwk89UEEhroWydwOIWePWUkmmtewldQQZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHD4ndNq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfKPhxkZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5240606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5240606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHD4ndNq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfKPhxkZ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH2g22377361
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FcFkDguCD/ilInffZmCjUgAc
	HpkPgkVvkAaNeAEJ7sU=; b=jHD4ndNqjnzEpOp7UspnMzN5/djWeqmgMuO5E9ho
	DLvkgeW4Dt6EABFF3O7vVtIUcdoVCjho2j362cFdBBbWcpiXdASJz/jJ5PGtw6Mj
	xndbTqmmmiCl3X8ZKTrvuMQFrad2NuNRcOkOnRI8k0WmaO6Rb/2x31Vw8pZ1o/U5
	hwlQApGnztlZ7nQBBb7LuV11IgUob9XhYF56Q6ZzflQ04tLdYXc85XxqY2zN31YS
	1agpdCiZsP7kgh8Uy2MXjNmEmpvXmCpM3iGIOnEsvmHtja0DT6IItDUC976Q/98G
	wZv+JGyxNvSiQZ2XKOug+BgkuPRxKqLDY3Xjm8N9adRg9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7ut4px-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:42:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f3969a2a7so556462185a.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462953; x=1796067753; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FcFkDguCD/ilInffZmCjUgAcHpkPgkVvkAaNeAEJ7sU=;
        b=KfKPhxkZQ0m6R0mzXCE0gsz3KrmJ6IobVz3wVJYlAa/rO62ehFsz1axHBGbmQQpij4
         DV2XqeajuzvNfpMqDT/fq2il9cxObb5Dl4EwP9Z+oMaQdjXC5QcAQHa2aYqVlkTw0XVG
         b8LF8bk0jqIz6wLlziKk7kObINF5sD1/QLOPzEwjPkyyVcLI6MV9kgXEwrpVa83lx+XE
         2H0DjJzx2rPDDDmPUG+OvRoW6U0YjIfZ48WsVmzBfdQFM/t7/Mk7DDtL/P1Fgz6j4R9W
         G+ovDA2zLbsEEFt8759q4ZsmcN215soDeg+G28ETDXAaEAhJibi/ZvjdefL3R5TH+tDL
         tGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462953; x=1796067753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcFkDguCD/ilInffZmCjUgAcHpkPgkVvkAaNeAEJ7sU=;
        b=RYukBoGmmubTd9xewsWMH6WePhi1S+hzoUhCanVRmYccT3eF4hqc4pi/xSJFOMdVBx
         HLXdyw61YFfJdYkFyXhvZDbFQ9srGECPZaiHvrcm62kvELgRv4JxtxliXErbYGZ26cLR
         aJh0ul9OLrkgIwHhTCeQ9nzZiGGLx2np1wy98BRknH/EuZ9Bg9yIOCfhatoWa8o8J1hn
         K3foXOzKUr3+nuoTWXzrI8Mjpe747SngHuTo7dL1yWyec9zuTzL6wcP8q6H0Kk0ioGIz
         8/XaBDVQkS06hEWSQrdUcPUS4lPA1OxsflihTCdhQf6x5DS1ig/tPJDDave9ArDSt6v1
         Ohfw==
X-Forwarded-Encrypted: i=1; AL+hErHb1koOkoU4skuUG5W/gk7ySUd2WaPpoNp/rIn3+jmeMj4ctT7l4NGGOsWhlwHedu96dMSiRQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/c18a4u6m0/q2hG7SDbmKr57HmLzubyM2Xje4A19NW45m4Mq6G
	qOM+ivNG3MCeu9i+lQQpHUm6aO54+z8M4PSA14ul6Qqhh1SEuMZF3O1rWCAkpM6XzCt+3BrHUkk
	tbon4u52MEouXcdIVc3lkKGzApwXqUill9rWKeSVrqZh3aEnxxzoaIF7wmA==
X-Gm-Gg: AZFdTZcLPtdo0g4Snt4yNvIdw4kdUkjqpwA7VD46SBeBBNWUQks9EtcgGSGFpQ1Flir
	wTTU6wZgNMiwRuy6xqtVGnspmW+hLrqYJLF/7vcrt/PyK0imS+bDEMHJJ+T54EoUQwVCNMpP3la
	re+dVKicY+3Ptsv69U6myb/16wH28wJQwHXILGqPbKYhcuamtBciwj9ghsgu1Rwa7UAH0Ob82YA
	viv0s7svJYBbH2of2+Q+qNbrmDHJNbYyB1v4qRJJAOII4OybX53+keiUK9kr70yrQAu4+IQPGxv
	hn98aVmkUJHaoKj03iKrn6aCazo/vFjEwaYl5q11Xq3WXVAgJ+z4Yh9iyKLu9afWWaUEfb+5btc
	H/1uo6hCER0/p5/UPMj02FGetj4aTV2aSuW+66KcEelQtzzUKblssVZc+XTVk0fVn
X-Received: by 2002:a05:620a:c42:b0:949:5c62:e77e with SMTP id af79cd13be357-949ba9c6de4mr2148821785a.14.1795462953048;
        Mon, 23 Nov 2026 11:42:33 -0800 (PST)
X-Received: by 2002:a05:620a:c42:b0:949:5c62:e77e with SMTP id af79cd13be357-949ba9c6de4mr2148815185a.14.1795462952408;
        Mon, 23 Nov 2026 11:42:32 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm374404505e9.7.2026.11.23.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:42:31 -0800 (PST)
Date: Mon, 23 Nov 2026 21:42:30 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4 18/20] arm64: dts: qcom: milos: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <2qyauqpne4p3a63jtwvvsbeyulgitvjrqmdija6pjkgh67m6c6@a5qe6jfxerga>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-18-be30526391d9@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-smmu_interconnect_addition-v4-18-be30526391d9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: UPWK32cH2qeGtAsl9fZ4AUDdaAxFKIIP
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b049729 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=II2oZZyV4uo1nSvD-RkA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UPWK32cH2qeGtAsl9fZ4AUDdaAxFKIIP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX4xht3P869yb3
 dNa8TGbdYIB22p0sWihDgbjdNZqY2qfkmWAD0UvCtJYJpOjjfJhQfcvCDb1YDK739hFeHnXXcES
 ryPlqi9IYl4le6bCZvXkH46kusnQPSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX6UlZr3C/mEBs
 tcZz/T9226/8UI40cKfECFj+Bi58Pg62IbO88pydjaEfLIbhOtWNxquW3coDFrJZY3baIgysnS3
 Km+j6uMusC//8Deno5wHT5HVKjV26hUcLRfGEhdYj9VenrX+RvFYGYpZUFFm5KGyT4UDdZTtMHu
 rW7ysODhoVx3hezK/hxbc19ykdBz487U+sZ440jAeRdBdMDTbB13JKW5e1CsMhColyOKhEnsNuS
 f1vjpd1xF4FbaHRAhs4qOH5+PCGlH3gZ3Fewbuj751TLasQkXg13Lnb0D+oql+jY7YdaJuaYtS6
 3inMDUsxYnL9KA0awBwT67tinvnqKiMIYqDDutNhIlUkyB9T/uaUT7IgMASlVTbF9jwPQU8MlwA
 S5XSROlKBjNri1pqB11dbOFh7t5vUGHdGAIKaMzBXSwf5iqG3Ze9KT1UNu+87Xj0jea8KY744cA
 V5apktrLrJ6wj2UxQUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:49, Bibek Kumar Patro wrote:
> On Milos the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
