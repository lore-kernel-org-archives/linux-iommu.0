Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48323B3899
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820475; cv=none; b=n2pAYcwejZaKFJ6BtP4OZMrtx+TtPySmzeSd5l4IH9kZaL6s2oCb61bLvh6726Xo9UdvbGh9Z/DQf3ibL5Cfz3769lErExOzMIUK/SjbVgfVjwJant/OfAz56R0lOlsQMQOBSUB1XUv3hpL+SkdA9+a9gGI+DemiFwlEboHetIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820475; c=relaxed/simple;
	bh=mA30AduXyStobxtBMt7yxuIZHtu4wfbxWYCgCHvxRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL31W9QGNGTuWgzANucWLbAkGS7lzO4f2SL3Qba3DI/arMjZ1cUSmg9NqKtwCk+wPtTesc4VR6GhigkqH5znk17Fkr21rya14iDUGGLTamt7cWpm/xKFnSENYrQOThUuYtryGZt1PCke49b6w76UrunTfIQO6OMzKxoqUGYB/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbGNhjXm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdTb5EwH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbGNhjXm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdTb5EwH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RGBD088070
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L6SX71fzzR7itcx4t/pTijxV
	Fm3CAO7RKTuuqSh0i70=; b=MbGNhjXmN1zqZeS/hPrCbCFJzkgAjdFDjFnDS99R
	f7IOPISYwKyUVhzbXudIN4/qCIMOTaNmezSJYoNDiLo24hYUELj7xP0Ibjlr4Wv9
	Hc7kQ2JN4Ocx7Lb4LLN/NPSWLRJe2oy7q537rNdQuEdyN5bmVU9McbSJzd+b/33i
	FMgRGWxeqFs6Kr4YHwbggNyTqq1fLK/l/0azLWqrfxOOotXSk2I8J+0j7jF6P9v4
	8DXfNZHhRmCKDRrulhC7nvjAeGSkXC6wrFuCE85CaHKUB5E963M/YFccNb6y2HV9
	ABThaIHjQxukZnWFfGUhbnrreQc/o0tX9YsxpDshUfGQww==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hw2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:47:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90c8da50f8dso33647916d6.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820471; x=1788425271; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L6SX71fzzR7itcx4t/pTijxVFm3CAO7RKTuuqSh0i70=;
        b=PdTb5EwHOCoEti9ukJ9yJUyMhb2pERDceC/maG8onddJTiozZBs8fuApmSkOmHXo8G
         cFSDKN32I/HYgNynrfYRzF7DxQG1CBhf1RkF9uRnKaGQsMSnPCNSB0HjOLsmO2dDC459
         HBPY7UiiGDudiKfRQTOqHjmRdlmfPENvDps1+zfAzUgFfBD8dK3Iq5IuTi88rkKwaGbN
         W+SBk2Pzm+jE4uIym+sp/FLQpp6jXZR2KsmyRzC0gdG/ZN9pEG/fk/UynEDHPTbSTFMx
         bfukH14u+6XEfAySEVnc1KmpKRzCzrLHJ8bO7bXJyhv67NJdzT812bQV4so997GrgOWB
         8NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820471; x=1788425271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6SX71fzzR7itcx4t/pTijxVFm3CAO7RKTuuqSh0i70=;
        b=tEgBwK259ZqeZ7axmuc5o6tBAkxCn1OF31mHW8PhjdEKra1aF8otWjOr9d5wyJ00HW
         0hmoWacjBK2+/k4RzTlHE/IolNFDXFYBo9cO/21N5LGNaCBpNUjKDluOLb9SVCmmyFEF
         b/5YU+qGK3Y45NcaT4+3ROJSKd4mMR/1vlkWhZQG2vj//mbpF2BxhNPppjjgu9ReTwVF
         gUQbL/A2SpH1E3I/jBCRa4SC1oGYUnm/k9/h6dVqiSpus3xAEVCmUtBZ0KnvBlf8MIQc
         Ho82wG0vFOSq/FJPfOtNXiPDeE+YfIniPt3/nLFigt1p2bJf4TdH6yLkg8BnvRaHaTeO
         Vr3Q==
X-Forwarded-Encrypted: i=1; AHgh+RosJgc1Xuf9/i45wgLEfXQzjyCr4d2GbTF4/wcFczNF1zF+lILv7nO5wUGTxLuH55nY5tToOw==@lists.linux.dev
X-Gm-Message-State: AFuF++n3PnrdFs4pUjLC3Pxfr4LkJRCkVydm7nE0u3ZkVpVDdxoAZkG2
	HmGhXb/Y/yZb6ChsHJS7HJrtTPY+xcarZ/xR9j8izD0dy96DqcE72c7fW2PF/cEqe0OCS3f+0Dq
	liykEuOX5BUK0fAcFmM65URjIuSO4RZiWSftJPNJvnKc/9Z3iUrbAt4lPnw==
X-Gm-Gg: AR+sD13TK0WjbSbFi0gQqCsoPNaV+e+znCwdUo0wLqUJd1gspM+WARVTLKsr4TSpIoc
	cZrECLZRdlU7TNevw5qD1ypqpBsDzEcQovvU4QeLjyZT1rAhG7xPfOKUvlwEKcADsVx1TwgdYcO
	N2xc/PzDE9FdwyVtC6tMuegEzGfZAnNRUXXx9PuBqlEDGmBz3YBrnwMHn4jDB1wz2IpaiJlu5H1
	omyMD2yMm7kUKYqu4IXS6/BVRm2zKSZUeKs3IS93nJmOqAkQII6xNS6WKTMUtCy5fPljku/8G4q
	fpMJFFKo0tVN5vyd1XPyCqN8j3Yex2A2eqrih2ft7eadfKFb1Z1iQV9dRVCPrS2FmTvMC5HQBba
	HNiO6W8V3WiiwDol3fHYsVenI+T5fMiUciss=
X-Received: by 2002:ac8:5fc3:0:b0:52d:6c92:b5e1 with SMTP id d75a77b69052e-52e423e01d9mr134394791cf.27.1787820471027;
        Thu, 27 Aug 2026 01:47:51 -0700 (PDT)
X-Received: by 2002:ac8:5fc3:0:b0:52d:6c92:b5e1 with SMTP id d75a77b69052e-52e423e01d9mr134394501cf.27.1787820470600;
        Thu, 27 Aug 2026 01:47:50 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56dfb8sm50721065e9.3.2026.08.27.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:47:48 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:47:47 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <lxrej2bonrvt5ew7e6wjupcaptj7nxpesnzwvktjusawg3od2u@v3zb2bdjdilo>
References: <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
 <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
 <20260826163234.GN3325090@nvidia.com>
 <l3xyzbhqfremod6swwiks54znvoqy57hmqpsdlpcji5czjja4w@4qgiuwhwlie3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3xyzbhqfremod6swwiks54znvoqy57hmqpsdlpcji5czjja4w@4qgiuwhwlie3>
X-Proofpoint-ORIG-GUID: MKy8Z91TjFH8-dO4rOJYmcg-lIvLJd3w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MiBTYWx0ZWRfX7CO+77B6W+Bj
 6s2ePfKiA+jrP3nskld9CTeiMSMAqqQ6WBKvVAig4bjDegXcpa7pYcltgjz7Y0WvK6ze3aGXr40
 QXpYiSeEIYWDM6fc6aLTwcg3QK1BbsM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MiBTYWx0ZWRfX/I53XC5pTWiO
 m/E2mqK4hIVFNxMU9RK/+xH8qvR+kcvHdrY6PFb894bRX88sIIfQkRmbuwdBs5DrSoO8xsudEjM
 dTKgx9zK+Wyz+20m3AK51oNcQXCPClLd8j2p2GjjUIX2nWoR8q38HKkXsKWSA5gbsroCg5xoAPV
 O0lZSfxCR3Gid8f16XU28/5VeIQAZF6yRzwcw1vDDFNnRmL0rzJo/zgtm6H8hDDXAHQZvP4yUfQ
 LysxWr88NUpJzURKEY8XLV++gTIy5CphYVQ0Eb5LC6lS03GJnwRVuorWhPg1YQO8eMenbMEnH2Y
 iOKkRthffOy7/zWSI1RjN9XcNX6+/2CjGc5hXnydqCUhasHRAQmD31BW5Vp+WPA4ay/WT0/5yo9
 nvudyER2vMm85aUfbOAy0q/AEEMByBjR6Phg8rHFRqEq3ACjkAvn0tCn1RVtzw458Sq8HGXw/RG
 YIcFCRfwW5QMXpVdx/Q==
X-Proofpoint-GUID: MKy8Z91TjFH8-dO4rOJYmcg-lIvLJd3w
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff9b8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=iiT1TCLmThQewConTdcA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270072

On Wed, Aug 26, 2026 at 08:11:58PM +0200, Andrew Jones wrote:
> On Wed, Aug 26, 2026 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 26, 2026 at 10:23:20AM +0200, Andrew Jones wrote:
> > > RISC-V uses the same basic model as x86 (an IOMMU-owned interrupt
> > > remapping IRQ domain). x86 makes that domain per-IOMMU because its IRTE
> > > resources belong to the IOMMU instance. RISC-V makes it per-device because
> > > its callbacks operate on the device's attached IOMMU domain and preserve
> > > that device's existing MSI parent. The IRQ callbacks provide the lifecycle
> > > hooks, even though the mappings, MSI table, and device context all remain
> > > IOMMU state.
> > 
> > The irq domain isn't per device, it is per msi table, many devices can
> > share the same table, and the VM should have a single shared table
> > across all devices. That's the core uniquely RISCV wrinkle I think.
> > 
> > IDK how Thomas would like to model this, but you will get a better
> > result if it is very clearly explained and asked.
> > 
> > I would like to keep the iommu out of it, so I prefer if IRQ code
> > patches in its MSI table pointer broadly the same way AMD does.
> > Though AMD doesn't have the restriction that remapping only works with
> > a S2 domain :(
> >
> 
> The per-device irqdomain model allows multiple devices to share the same
> S2 IOMMU domain and MSI table. Unlike AMD, however, the RISC-V remapping
> state belongs to a replaceable S2 domain rather than the physical IOMMU.
> The IRQ hierarchy must remain stable across domain changes, so a stable
> per-device irqdomain which operates on the currently attached S2 domain
> may be the closest practical equivalent. I'll explore this further while
> reworking the irqbypass series.
>

I think it should be possible to follow AMD's model more closely. I'll
create one IOMMU-owned irqdomain and install it as each device's MSI
parent at probe time, provided the device currently uses the expected
IMSIC MSI domain, which will be the IOMMU irqdomain's parent. The
irqdomain will contain no per-device or MSI-table state and its callbacks
can recover the device and operate on its currently attached S2 domain.
This is better than the per-device irqdomain since sharing it avoids
redundant domains.

I'll give that a go for the next posting of the irqbypass series, based on
v5 of this host-remapping series. v5 itself will not introduce an IOMMU
irqdomain.

Thanks,
drew
