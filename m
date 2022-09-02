Received: from sonic304-25.consmr.mail.ne1.yahoo.com (sonic304-25.consmr.mail.ne1.yahoo.com [66.163.191.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D34749E
	for <iommu@lists.linux.dev>; Fri,  2 Sep 2022 22:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1662159579; bh=nKSHGBjAyroFRynrG6UqfsUdY9Ao1irI3u5pc1BzlmY=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=vuuLLr6zqu7ngS2bg5yw4WU5jknWlLrVUMnYt3V8PqcAoIJTai330ANEhM3k3JsbW5ddYJndVBltt+RJqlX3UCyYQXl//Z+5q6K0RW2lQAoUpyLA+7O/pv20K3zZNk96u4bswZCjo0/OeNG2iVBiVgvVbesv8vFfU8snuabRnBc=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662159579; bh=dWs80AZ3RUeUoG1yhWIK+MMKEkL7aUH3g+dfl3KY7NR=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ckUwk97Wm5gJd0yPEVgsv/5uiqzBmpWb76h0qFaoQG39OR3EeZMUgkAr88fz171ysbAImVlv4kbpKvFyIcRZuyebM+Bas5bCMudN21UxsGsjXVonMS4m+OEwG6ubH/dlTMdFmVkrHaSFNXyh3Ek+VQJKtLaTygfoMfmJUS3zBwlQOvTvt77qDQHwav3kThuLfqTFCZusArhoBfBDF7Po5+P7bbFQyqQqRazzlpPQmpFwDMx7Yt6wyk5KLJvrF5PpgJUIcvffsmc9l9v/XrthDKsNUK0We/kHXhvgyhqTuDBzt9NeVnWucUU140icq0RWe2z2wuWnRNtyciUC//fLJA==
X-YMail-OSG: 3K2POysVM1m2_PZaAQOKnJH7oN7VnUqqU9bA3Gb1n10MklUYLoaXWdNfgcq8c9a
 DwOQZtDYg8cwzVlW13fWPq_xpHQDPb.H3zls_5ijC5vzLIaofvw5I1_qYBT_8s5deOIEkPbim8qr
 UVHz4D.IpPTe2HhtNIqhVPjp_mmM1xz_A8PRiAlrc73b5dZfOX5t8PA_Gd6b84CtLnhdDE.yk1rm
 66cSRWvX1M5aNFPt93mH5_v0wCzibTsbjtghOSUjKpjv9kyGrPtMQwe.2Kt7I2rEojeuFkw5M8.i
 0KNL3.43JJUIfpgopj4M81qGl5r6j2vAAJluMXSPK70nMI2406lFJ7_tCN_lDCUyOqlDtRsJcJKk
 tUNt8C08gpR9flKsgVEuMuYwC.dFOK0hHn2EifN7_Of1Uc.kcj6EUGPsp.xQqiJBoT1Tmfmfs9jT
 gL1ffK1j81WiOqd8DMff11hhTtFx3U6sAaElRN3hCU.bEKIxmJvGNvdvy.q1OtOAeELKUvOhUhZn
 nnk6DMuShyaT9JpE6414Oe8NBuRMjll4gSRpDfzKszgxU9TuFdXYhw36rqKHrreM24ZNxATsWrD7
 65Bgyg2xw4f55XxbRYpDYliNINSm6nwvl74fwzGykX3RIOvMmCWcGb7cqe82mNsTR4GsVGp812mM
 YH0Rk8p__FlPqjC5dE8uNSDRbAqmOX3C.ciF06PvLRWTSTrAty.7X9IpfYCXXyddRev3OHmR1BEP
 A0gAhKkzv8il006wKtVkYt6DUFk3KODjKNfa8O3fTARoBS.lPVb6tv8AzinTGsV0SU6dKu8LAHNZ
 2qtYcF2uHBROm5A9NxYGHAIkUomi.UoOm6R4CGxZgAOST.vEjmBiPxATGnYbLM1uNGVpSM0zpMG6
 R7EdQkZNS9AvLAFGwB3dkPrxKEzmsPAyTT63k7QZPqmWpCR1K4GuNKca9I8U6x2y5XDeGOyJegZQ
 HmFvLGskiFPVGsbID6gqJG1P82J8MCdnSNQ7_LExq2hPcuss9wNpQLa3mWxbPDFA2g63kkS7QljY
 mjLjvEvjDwRpirQQkw2Cce1wwjWBUJpLBoYEXQiVnEH_GNzlJNyoq202grUrtMxW4tDIpFkOy_Qc
 H.Xmy18KVTfOXRWkQ7UfSgNgqDobsuUOkIQO3eEdtluhsNv5X8o68nnpwjffNWyaDKeDWZEICAkt
 RHYbRvPWm.ZNyCzB715lNo6ghorNt4M4lcYCRQSmoJHZFrBetKz.m2qGYa51io8R.fZL3fWeWar9
 UGb7CtQsE4cjnonwrgQx1OLejEbsz4KlFfjAZiPP9vs.fplx0RDCkq1kYazzPahFPNs77dKv5V8i
 AIsgGo_VPUHECbdOGs4f59.0XdtMnGoCySyyqNyf2h0j.u_ZTVb37xvfZ6e8Smlgg20Vivpre6uF
 lr8zsfp7ph0KqI7mRoIKmEsidoKsAjxpNIqQHdb8FLL9tkncXQjnlqMW3U9imwzDSjQs5ADyRmG3
 Li7yePkhNX7wog_I1pPyP8xVNVop6bMxO3RVkP7F2vv3Vu_1PoVWRU_BSQfbL_iOxgt_gIik2OAQ
 WFVqqmzvy2nz1eHIjQnXlbyhcnptaCwLZ39.Tnn9VQ.axuBL4FQfMSMIQkkEvGVl0GfqNkOiWanD
 HPd73YIdVPpWxFPdVxFj_qUFOH2kiqF91E1Mjd2a7YrUetYNMsw8uvmb7oxoliMcR2IAKP60PkTF
 fV5wc43ZMNh69LOptvL29a9qOcqpbv4GX4A785xplomPIJKHcnQP0d6Cvef0MCK1TywW68vn3csh
 1rTGZ2ovsaTmgmonDdhGq1hZhSH9TedM.T9A4dOQegS33_7Hy7mFHduAegAxF0DGVR8ybvA0B0q2
 hqYm0IoJXRxB1Synh0rKG5gDTcTt5ZwLn31HnbZwydhr239z5L0rUwgD98VZGgOs6GCCCXBVocca
 ln5x__V4Re5RAeJSXZKpYXABLkj8jPb0DKCPMd70eo80iCH06EfcGl.dqMsvJk8XM6sG1oYSEwj7
 0MIVvCSQlFSY70m.3TpnLQFu_k0fmncrnLXRTjJBg2S0uDIcfQXTwiUEm78L9fT8Nuc4LMiky6Yu
 2N0t1J0rhTQFeVvcz.uUSkwPO9GDPBPSENjEWCZEMWqY3N5I1svQBtK7giQTPurfPYw0prdXW.D5
 nW.S9qN5ZlFcFZgbUvO6R_i0OOct1gXirXY7hTYupuES2CZ9KL.MLmE9uniKpHeX3PUEdl7yTBDo
 VsEBtfoabwpAgMULwea7F
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Sep 2022 22:59:39 +0000
Received: by hermes--production-ne1-544744cc75-m5z2t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 77a559a4d5ac38d1243fce6e938f8241;
          Fri, 02 Sep 2022 22:59:36 +0000 (UTC)
Date: Fri, 02 Sep 2022 18:59:30 -0400
From: Steven J Abner <pheonix.sja@att.net>
Subject: amd iommu configuration
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev
Message-Id: <6JULHR.A756AJXX1SBV2@att.net>
X-Mailer: geary/3.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <6JULHR.A756AJXX1SBV2.ref@att.net>

Hi
I was referred to you from linux-kernel@vger.kernel.org about the 
following issue.
Here is as was written:
On 9/1/22 11:36, Steven J Abner wrote:
 Hi
 Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 
as base.
 I stumbled across an odd situation and which lacked Kconfig info and 
lead to oddity.
 /drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 'tristate' 
but unlike many
 other tristate configures doesn't mention that module name is 
'iommu_v2.ko' and loading should be done by adding to modules-load.d.

 The oddity is that by loading as module is as follows (differences):

 builtin iommu_v2 version dmesg:
 amdgpu: HMM registered 2048MB device memory
 amdgpu: Topology: Add APU node [0x0:0x0]
 amdgpu: Topology: Add APU node [0x15dd:0x1002]
 AMD-Vi: AMD IOMMUv2 loaded and initialized
 kfd kfd: amdgpu: added device 1002:15dd
 kfd kfd: amdgpu: Allocated 3969056 bytes on gart
 memmap_init_zone_device initialised 524288 pages in 0ms

 module not loaded due to missing iommu.conf dmesg:
 amdgpu: CRAT table disabled by module option
 amdgpu: Topology: Add CPU node
 amdgpu: Virtual CRAT table created for CPU
 kfd kfd: amdgpu: GC IP 090100 not supported in kfd

 module load through iommu.conf dmesg:
 amdgpu: CRAT table disabled by module option
 amdgpu: Topology: Add CPU node
 amdgpu: Virtual CRAT table created for CPU
 AMD-Vi: AMD IOMMUv2 loaded and initialized
 kfd kfd: amdgpu: GC IP 090100 not supported in kfd

 Note, only difference on witk/without iommu.conf is:
 AMD-Vi: AMD IOMMUv2 loaded and initialized

 So does this mean missing features by not having builtin?
 If not, should Kconfig have hint about module and loading?

 Steve

 I wish to be personally CC'ed the answers/comments posted to the list
 in response to my posting, please:) Not a list member.

I hope you can assist linux people and myself. I assumed from dmesg that
it must be builtin. But also wonder if it should be in amdgpu or tied 
to it.
Steve


