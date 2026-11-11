Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402101;
	b=OtelYsxTRaaHEoo59MDC8yxtAnppCCKzp1j4jS7D70kQs8lt+KDfK+KV3/BPJO/2YecT
	 Ui3JSQ1BQ8v4WAyh1M3Tg95v/XcVp95RIClu7C5hE7t0tw/jqidLMKbptFS/OvHagU1aO
	 jzAWpwpU0/+SVn70uG4vuLqXhltihMf7ZKDSZfR2iGFtCxHT+iU/HM9l/41+9GL1xqAZV
	 WEIGxb1UR6+kbKkqSxoQ7DPqr9XtytUZ9QmwsZSjAC38HdqV+wCiguumATkQvFeIYH9qn
	 5yO3yJA7PnXXwWDz6GmNfi8PimX8QezCnLSJxR2VzZY2oxcGfWDzrM5wXPmIbXq5FuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402101;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
	b=M1SNcQYkiuXw4XqwTQPbT+Rt0QGYii7yxJ1LKTJo3tUAKfratICdO8ElCehBKfmZ7BcN
	 /06fl4HmWIlTkQP7kPjicVtzdyAqcqXSWT7bwo8TAmf0EV5PIFZr5OkOsLvakoevZTGCu
	 SwMTo0pAIIKoyy6oTt+0Vb0oHLz88vuc1A1uGyXmDDNJXKc4TRwvMNmpvMdus8Cn87TQQ
	 Z8O0ZaitoiTpxdqla8y4A2P5ZsPbZ3lqN9ASh/VyenfZ7+OHMf2w+5CyFw+fUcLC4Gp+U
	 FSCIt0vMDBTHrhTnXFVkgfIAWgt/suSQlOOkaMJJfLWuV7/leqpuT5fLxW0KqRWECrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duTWuxbe;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D4606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C06D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duTWuxbe
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ1Lm300545
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fNNA5DINfFRpf2eORoYgUUVl
	bLJUUgtkmYcnEbAYKiY=; b=p6q+meWfh8pxTAsOPcNqXBXxXBRbH+GJDC4uiwKA
	LJ5hYTCU3/k1FKYji7ugZnbHErDA5WuhE5KzDaz8lgoup47Kf0aitPgAEw3rW0lp
	tMtswTpUYDD8q4tClQtiOBprE7ZUy4pXagV9SgI+lMAfwYQfVHVebO5KPPIcUnid
	chmnqaobA7mVsL+v/gdx+NJL5U1KFoj9M4mB1lr2ZMcQaWN29IzteadEmIgwVhrK
	EIpAcU2xW1xN36ygYXdO+5SKN19CrB5t79dsRs5D885Pvk1tYO8MeB2FCyVs7Qv2
	wejjCK8v+qWke5jhjykBYz7/jQCHfyyuSVzlG19XahwgNg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjrk44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:01:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eac41ff334so2898114e0c.0
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402099; x=1795006899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=duTWuxbeL22Wv5GSwX6dEjVQaRjNKkp/GI4WKaHVvOzDQwwCKOAQFqpRD/CDxXYz/J
         N39iYDjmXZrSYtulFTw3F5i8OS6IkONK7bL/61lkXE8Hx60d6IqYPVPaIAuajnb9Ck+D
         RVqOtIEJPqeQJnkfwXUsWNZiCSZSPkuDwEM2gEdqWcionzRsBcy5b2DDRkiAHWd0AnbW
         qMFCZGWU7O5QZlcgwwsSnHHICtAJ9Wa8DaNtmhjKzuNbswTI6b/7sVMbmHXdNKdGd9z6
         W4xwgIIVFSQbTx8fpyTk0zBy+TZbh1TU3IkLrPTWaki56av1kOu3I04cAqYIqDsHp3c5
         OcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402099; x=1795006899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=yzld4fHES1jZ8IZyhOY2EH8oY0u/+hkBQOuO7T/9VAlxK9OclQV9B8bAgnM/cS8Fyf
         mRWDibRsYhZceKlVTf2BM/FKs5uBHdTs6qejK7E3RK53ajAdZCchx/YCOnL5OvkDRah3
         6vG0x9GZUUe+wkuLJ2k2QtsSiE44kDyLJTIJPgOpbGPRZXyGZJYuheqRo9MEzcV9lQFw
         f/vqTKzMraexyy/dNPl/1/UPP9AxhLYVVOzKotvoJxbWKm78ktvA7Ld0nWjV3DLQjz4/
         IPvcgbDakvFWvPxdW9MI5Rr1N394LUfQNySScjjEsba3TNu7nbCx5PeG7eWAgE7OFfBQ
         DIiQ==
X-Forwarded-Encrypted: i=1; AL+hErEj1uwaNLMBCAYakOoe4g2zbXorFyVFyEtRpNZZl1UPIlkRqTv7P0q4hFfwkqZpEjKFmEGjlQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KzB74yL5cQqplEP9vCgLLBUiJqgxUmO+eXfS2yhlnps6Uq4vv
	3jUTC6AjHmkuT3VCr7G6I0mOZe2grdXc9efWDVqi8rb34lGQ+iE5bvktrTmLyZnnH83XbPmZ1fj
	0XmYZ/4GwatRx96fcRIsVjdBeB9Ec/Umo7yfe5LnB+ckVtK4ZVTb+6vM6oQ==
X-Gm-Gg: AYBFou0c9pDx6+COZSMmvc+MMHHyjkmZyAtK5OC15MZIrqYD4yzgilMo+U+PHtMiwgl
	OrZBjTa4BHVhHHNyC6e1+5b2F3/KFNMNl58d+4+0fGcwaL4ijOBOmTIPQzPx3BYujY0kz/g3gbU
	fDpyqoJ8dyi+oXWAKaF5+AuihsxzlDWjKORbI4mEsyK1VG31FgagQgNi/w2sDm/X7JfXQZUq4wa
	ldMoU5XpMdgKrYvAWMm49ck0plkURT1dR3OPMlZuDfpJfEQ08zMMRPQlnVSR2ypLxL5xDS86SDS
	H6l8duNqXWw/ltoavnq9gFS1Wr84lwcnc0434tSx9YHUWt9Bf+TxmFviCx1AQ5i47Elcn8xzmPS
	TCqVYWtudGCHlzfciLDSpov125ast0qSPpwSmjaRd+HKG3dc7i9pwTyJ/CMEfNU2g/b4TCuIDap
	KRsn9ynKW3ehRr3pkRvqSnFcP5VdY1RXcivbOehbfE77pkqdL+oeUg4trYdcW6+A==
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672608e0c.8.1794402098942;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672510e0c.8.1794402098347;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a657sm947505e87.11.2026.11.11.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:01:37 -0800 (PST)
Date: Wed, 11 Nov 2026 15:01:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <h7j7lyl6d67xfdw3gyabfngpurumbqd6fkcvuhyi4juashcx5r@egybwhfdaonn>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX+MqQmD74xThh
 BfA7yVVNliBnf2maI7aC4/VdOldgAZvvSiZyLIFRdo8YbxntW7bUdQAaIJthhHmqrDfeVguMjlS
 46IMyEPTZqy1LdazauR83K1tcJqy54gb6JJKFeyitSH5hqH84gKJGbneTDn7Wnpkrca4TErqFeL
 RpgFo3668O3lk7Y9mBaX2vPis+vGgqAA022sFGB6RSBKQdAcMoCdQ+GdNHQuZNRIXmmiPrwR3K+
 XE7ZkFlABtBiDhgpgYKKuaA+0IxfupnTMipOrOtusnZERkL4qap/Xl4EsKu9cXiDObQtRAvFIU+
 8zvnssNhlyNdQnThRAqtsadzZnuqPuqrthtepTi6oRUZz7ivnyJcYZFjEZ6bpaw9tjMqej01g04
 UXgASso2hyi+LQiQ9LeLNRxoQaFkHiL00xjKvDQV111SttOaddwD7AMsIrMSQENMikIrZuBzzCx
 Z6UkTF8rzVIsrJpJeIg==
X-Proofpoint-ORIG-GUID: aSGs5aGdz4rPGb9UGQzffokc6w1C2WQ2
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af46733 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ycv8Z8E-TvjlFfbjzzEA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: aSGs5aGdz4rPGb9UGQzffokc6w1C2WQ2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX/4c2M7kJVhGg
 2p8eE96FMcOqHEa59KE1HJWOExmr6gqv0RLaNN4Ia5lyKU78w+WnmdvEK2Cu7xcezdhdA/OnwVF
 HLNFI5U+NiVtAsrB8UMGMyUxR2bqLB8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:23PM +0530, Vikash Garodia wrote:
> The series adds support for recently introduced property 
> "iommu-ranges". It adds the required checks to error out for cases 
> which are not following the schema definition.
> 
> Iommu-ranges was defined in schema with this PR
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> The patch series is being posted as revision v6, since the patches 
> were initially part of the media series [1]. The patches are moved out 
> to get review comments from iommu reviewers, which was otherwise looking 
> as a media series. Happy to move this back to media series if anyone have 
> any concerns. 
> [1] 
> https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

FWIW these changes are also required for the DCP display controller to
work on Qualcomm platforms...

-- 
With best wishes
Dmitry
