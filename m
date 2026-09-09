Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458593939BD
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976924; cv=none; b=FHLZa0nkZRnag8W+XBgOcxNp3/eHoE9CefOgse1HP6GUQqr2IH0u2jqVgeB4rLoV8Pe9ckW6CRQcYHbLMiGNJYZJ7SwSBiJUsScesKLY9yEVZ/dOIBUgEO26P7HOQsNjtwvctk4QvrUk6yZYV3J8Brkg3qmItPVa4HYe2Wn2rGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976924; c=relaxed/simple;
	bh=y44p1I+qOxi8m4RJ0mcbujnCiDnKIlcRV/qr0KkL48Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns9stp6k8PeINUNvhWbh3bBleSOfmNApRHRI1A9itKEtSxZxPpYMCBtSBib4Au4enrG0bIBBeDXb4TtysgZZ6qW7aROBce5TKypPl44a5STXvOaDfEAqhpc2KClh14YEB+psexCP3+dWmdMuVx0Ew8qubk28gsshNLhk16nAup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzWzBtGf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WPGffnS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzWzBtGf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPGffnS6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H85me1938160
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 18:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=; b=pzWzBtGf3uq63Kne
	EMslco6jUfhmRL0h1enVEuIQ+qX3dy4P6lulU1cMPrdfemPvte0EqEwNq+h3b8gF
	/tD/3r2bDdsf9RSxeTUbX9fviPxsr6un4RwlJmJCRM25QBym760LZOQRD9kQXE6j
	14wG2YFkf/DHYLF+QAaY6hEdM3PnvYXb4YEHndt1u8Fkg9IMa/3LTThJ2DBO/VnD
	7LtcidhuptVb2MWvaGtpgUt0l2zusLHvvkQiZu1HcARkwIzHkURyYSp2fKnlY09T
	f0DFrUYD5hvimJECNOO7knIJpQi4yCKt+olDX9iK0zwhC+uNhsZ5V/XU6Xxxnpyw
	p0QoOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559t7wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 18:02:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so2615933a91.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976921; x=1789581721; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=;
        b=WPGffnS6sGJsWth7qi6/vB+GuWq35Se496mfbyMdgf4uENuX/hRULZjcGKrBiQoAMD
         +XFW6OUmKqxZ+9/92Ho/7AUkQ8e+39KRjM/XJYUtL5nf11rzTzRNx+zSElp2tAgEvzbD
         xtVVDLhZMoF6eeo8sLsT2cxHRev611OAZDG40lqr+/NaowMJaD6PySDnEAcqYpzspngX
         IbTljRTlIPSDIVD7j3xE4fj2ZDJxXbELdqAgrrKMSpq7kyV928z4GTTai5vLdhzadcGp
         jyO8TkFI2kaz+TsZHir7YcPHBtsLnUQ+3yk4wtcxPjUvCgEWRuMPFEYrWbMCe7GtqOV3
         WQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976921; x=1789581721;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSQi8KUPwQ7sewz9dZNSnIXQ06Hyg6lfMvkQJkpmQA0=;
        b=VXPm10+Y6mMpP6vlsHbqHM/h+jOxV4x+Pnor4XSvnkJaN8gn90bA/ImLdiTYWzdZ7n
         nju2XbWdpnaPuWpoKPli6sfn16Yznzrt8EHM6dIZT6znfs1OMyiR1vqeRwhXYFqlyvic
         kR5ivktmPRYU20N0p0uLuEaDtODKS7+KJFJ0E6qJmdV6ExG1FIGcnGS12jqoA0xftVC5
         QBSZA5dBfXg/Csg9TKm0I6R1+daVCphn+m51PY3R1C9Qr3RAspohaYiwQ9Aw2zw/RccS
         oY2pp4OW8baVTucH92ATxC5kE+pLEdDPVON4G5J1avMohKVo0cuSWcGCJz/qEoyo8Maz
         GPpg==
X-Forwarded-Encrypted: i=1; AKwUvByUnTXyBCBjyjfiJ2onknD81ukkQh6+rBPJR1dh7kbxJ6s0eQX1eTzoYHX7qPzquLyHSXDEvw==@lists.linux.dev
X-Gm-Message-State: AFuF++khtQFs103v4drchcnvHQ5sxLFTToVbt+V/066giw9ZWnxEyCQL
	fInws8zN8qCbS3r51lATHNyl7TTd6UimU346kRUFkXOQeJ8uYaTg0sjBEajj0yWzrxUbYTKMTYX
	NC8HTfmFAMZ1c9VT+FQmCMD6bniHH7yg+nk0+E9wDTvxygLYhviDhx6G9EMuVEFHC6w==
X-Gm-Gg: AYBFou1SsTXyFkML/vqtwuIDyaiIAFt36wZ7EtsnVJIjPAVWfOawRbWn2SxE9SKxkvj
	vY/OVtn1c8EPvtdZqKI65FvTJ4Kha+pd62TBygZborFia9z65T3LoSKooEmPjZ4+qTUHX+uBNn6
	25mhxzl5aB6DqGtFXpL8Cu0/oyGGMBIQXGbx2Td33BffGgcDR/QXK01ZrmMvT3tVs/RLimaamaF
	AwE8tx4Ao9M3zekcvhvQuXfVB/HU62oz3snwtITGybv2HY/GkfYJsL4HKiZJ+myTzVm4lLamks9
	ZStFrR8jWSbGU64Ns4zMHt4jeaSbdeoY+SlFbYIn4iZwVb9zjTU0f2Y0+eeUfjiPoSQcAOAHqFE
	5GFWrHeSfFBMYaHVOMfa8yjuZVEI=
X-Received: by 2002:a17:90b:1d8c:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39d70baf4acmr2943114a91.18.1788976920466;
        Wed, 09 Sep 2026 11:02:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8c:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39d70baf4acmr2942987a91.18.1788976919623;
        Wed, 09 Sep 2026 11:01:59 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm42727256c88.14.2026.09.09.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:01:58 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:01:50 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <skaestle@nvidia.com>,
        <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>, <bbiber@nvidia.com>,
        <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260909110150.00007bac@oss.qualcomm.com>
In-Reply-To: <apujyBWK+COCa3Ts@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.15663048615954357081.b4-review@b4>
	<apujyBWK+COCa3Ts@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa19f19 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=LiRWeZnokV1jdayv_KMA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mtWVV3ICN7-LX0txyb3Seb1aG4Ors8M5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX6uY3I+TEZgPB
 5W7WzJ074VJ0aRdrH1sFydHSjs11uLa4/0eRZquUI0UbKT4VyAjdJc+Oywn3eu5qwsPFyJNh7k5
 yUG2D7VQz0WKT6NXiAc/wnbkzvNB/G4=
X-Proofpoint-GUID: mtWVV3ICN7-LX0txyb3Seb1aG4Ors8M5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX/Y2vldWSyYKS
 VW7lN+dYuiTnt3uvx7nkUjaafx05+sjrOgfHebKkB5FAaJcjbQSu9if1h5sUvTU34PKWnqqilQH
 VZCJtwAL6zxE/fSfWrspLGJmecA2PAeNWVrlnQ2wv99sZxMAjSGw8pn7yrzHCsqUmoIL7XLk2G6
 7LArGhsuricmVDqggDbUCmIrCzK+MDO431GHTwSPm3F9gOmkKYw5exDom8RSwf/1upP2M+s5cTN
 46nkweYASA39DjTRpwX+GBKYA4JyVZUJMovmeZoUlO4FWjVxZAlBxRce5tZYMhChOogfDd3Nbsu
 0KgWYEUUjgpdbj4G4TfV6hZMFjR6FFoBhr1N+E34MCtmB2bsHUpz8PRs5rZ8CxoX5X2tyvFN0Iw
 C+O8MptpXpCsGLTpO51Tjz/KMYBGJLeatB/zU+YN7piGwbrVvb+F3JRP2mlveHWPlHrLNJaDEPg
 3bwgGty0Wi1fZsCdmkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090201

On Fri, 4 Sep 2026 22:08:24 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > For an unrecognised StreamID or a master without master->pri_enabled, fall
> > > through to the existing "unexpected PRI request" log + LAST-page DENY path
> > > to release the credit per the PCIe PRI spec. Merge its two info prints in  
> > 
> > Either don't bother mentioning pcie spec explicitly or expand that
> > to a useful reference - so section number, section title.  
> 
> Dropped:
> 
> For an unrecognised StreamID or a master without master->pri_enabled, fall
> through to the existing "unexpected PRI request" log + LAST-page DENY path.
> Merge its two info prints in the path into one single ratelimited line, as
> a malfunctioning device can spam unrecognised requests that will flood the
> kernel log.
> 
> > > On PRIQ overflow, partial requests stored via report_partial_fault() whose
> > > LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> > > iopf_queue_discard_partial(), matching intel-iommu's handling. Do it after
> > > the queue is fully drained, since the visible entries all precede the loss
> > > point: a group whose LAST-page entry is still in the queue gets assembled
> > > before the discard, rather than losing its stored partials to it. Nor can
> > > a new arrival race against the discard, since an active overflow inhibits
> > > new entries from being written to the PRI queue (IHI0070 8.1), up until a
> > > final CONS write acknowledges it.  
> > 
> > Kind of a general comment.  I'm guessing AI assisted heavily in these.
> > Whilst I haven't found much that definitely doesn't belong in a patch
> > description, they do end up rather more verbose than ideal.  Maybe
> > poke it to be more terse in English language choices at least?  
> 
> Well, some of the paragraphs in the commit messages turned out to be
> indeed verbose, compared to my original writings. One of the reasons
> was to justify against Sashiko that often nitpicks on a corner case,
> (which surprisingly works well).

*groan*  I understand that works and I guess this is the life we live in
now, but I wish it didn't give me more to read! :)

> 
> I broke it into parts; hope this might ease a bit:
> 
> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
> 
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the queue
> gets assembled before the discard, rather than losing its stored partials
> to it.
> 
> Nothing can arrive in between, as an active overflow inhibits new entries
> from being written to the PRI queue until a final CONS write acknowledges
> it (IHI0070 8.1).
> 
This is fine.
Thanks

J
> Thanks
> Nicolin

