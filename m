Received: from sonic312-27.consmr.mail.ir2.yahoo.com (sonic312-27.consmr.mail.ir2.yahoo.com [77.238.178.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AED7F
	for <iommu@lists.linux.dev>; Sat, 22 Apr 2023 06:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1682144747; bh=midj+Kfp9FmDq5AxarKzhgc0MJBSorgL4IFJ6LlsTEQ=; h=Date:To:Cc:References:Subject:From:In-Reply-To:From:Subject:Reply-To; b=l53ZCn5k8JlGUDQOiPdzXTN6TnZF1KBtbO96K5PeTmI3gZm5osNdelwK1GqCX5YvKyTuoqvwLph8dllCWK9+ZHgrkZfuhuVGMEfbBOaZevHzTz0D7sZYa9XXVFMoZ17sN4BLJotLNc4fKAQ57RTvTmCj6H6v3vbMuzHjLc1NVEDVxdIEYLL4SBmOnHZVU77682GG7VaPWGJMEmCwydcYoJI+RdYuH1UAuMyP6+EsaksA9qvOdSzu1zsNUbiJbiDpsm96IZdnWxszsS213feD+zbXjZ6y/y5Nnmjhj3kk15AqilODeQx6gA/1AqB66FXERyxyidjg8aRJw3BifocmxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682144747; bh=2KipPvC/isW/pnsIZcg1VP+I7LrAlqtyYXd3TukdKlt=; h=X-Sonic-MF:Date:To:Subject:From:From:Subject; b=mHZXIroNlQvQbe6e2nL1Ixvpve8Qk8rk9HFVqnX1tdjVZsWcXFlHJdLLPLZ6YO917k1x9a6+hxlmKdXbfEEx60E4GACY9Is7mPJGWroZeXUUgOUzTmCJG6XuvajnHL4idzeZ5L5flajsr8ZNa37rkMk2GpXp0/BpPh6LsGUhVGHsLHC9Ea3rqZnSDzgCm9NR3wAVxc3jTv967aRDe0BQyxtdzQwgk1BSHk+tMF/MkoiwBVkTUGAk6oZUxznVJoVFqa5cvQQeSgbI7DImmASvh3PuEUJsDE6Bg6Z0kcLKNVmQEqKOVsQkI3BG/6wK3JjCylSU32U3XrFxgtg88DZCrg==
X-YMail-OSG: k5mK02QVM1kzGbm5BlUo_W_g6Doo0SQ8gkV136bsr4Fj3Vjwwi0tEfZI2oGvmGb
 aH1hidDqF2q4LM9WgUdkXdKy91jAz.sAGxdk5SYlMFHiOIh8beOROOH0qvXZ4wSEOg.sLbwNH4D2
 i1TBQJ4eVLfAFOcb72Uze9a8c9JIaYTG04RnIyg9o0zu7Map1CLSE05l76m19XrMgBb8g.50p7BN
 rv4qwvbcujTuvY94oysW0SUz1qHuCdyBnk4uQrFh54ZME7ANBBC4BkdSYfLfPvmBDjXCcy2cr38f
 L1QUge8E3oseXlPtmFqK12V2CZnObFeregCo1G0SjzB6FBEYnS8RAyI8D.6nDRUb5YIlYlhLbDBz
 VZUSdFYAkRdcDKZO_aKTvEoYVoxWRteplDbBhy2X4NHSiP0pIcoS7d0kgKQ3En4rG847sY.UiWpQ
 9zghSsn4BvyGnFEhfLEkf3bz_sXvG9_fgo8EvBe8MOTOSo0b4xgeZEDLrKs.bl0RF9XOONLWbzKF
 jI8TdrV10C8VwM.cNSLiYXn2rJj36BI_W.muLd.JXcl.r8.GeBgjsj4VCcRSKc8dO8pM.bz70ETw
 Fwbatpt64qyk1v6zDlmuG31c.oO3TtVzN5ieNChlIWvwDwxQG1zOuWHgjljfpHjGdalblAZvLoKY
 iSP5n.F9KfHMBMZVGWcPEUlJgFgZhQkaUG2Sx8VvD_iVDkvk4066.h2X1oIWCG2kEaS_nFdoj.td
 yRPVYzaKfUhrHGxTEVXD3K8jl2ZmfP2nto4A_CvBAV89yosPK5D.91PxZMIt92unv.IhvxopHiiq
 7QAaJ2E5b5cqTmblTazdBv9iL8WtO_8qjYHNrCfDEHJLFrId5H788Gu0F1rQ4z3oT_3FcvXhh2cd
 RHhVhyLNDur2ORAfFwyS0GmhbhlOaPU0z9rNTnDRFQya5.pHYx29FMDj_98P_zyqRqtFPoG5UhXU
 29fky1nM7kR9ZNN2vWrEXHlw12GkZnld.YR1dZNiE57SNHZrnHcTej8fi3nB1aY6uNWHu4m0c6B7
 qMLe0_X5YF7rcJp6fxaq7bjgBFMNGZnroCptKswzmbO9IwE3lR7_Y_x.kz2IyU0.vwCkZ7cltOTL
 qoN.IXvAv3ib42z1y4Pk47Kwabl8wDQBbZjgP6boTlMyOe_APs6DiPpTv5tXMqiiY639NzepC.Y9
 UhULp1WoHh5jzK5gvLKBE6L5ODnatXF3UfIRML6BZ5nK9lCZadoKXPoOd5J3XD6oNGiQepfZwVNf
 Mz0yXJka1EmDSQ80U74YIieZFUqWEEpuD1Y.jXRpat2v10QWyVp8DbWCOocsJo2si0g6lwaiLF7M
 f3KbR2vngYPFBSR5bGptO8PMKeg_j7cnt3hQIYgTtmiSJwFth.J1bJFwDxxjeeqsivHYaGxWmJXo
 q08s.7G.QCLzlScYoBTBDqKA5dIUsTH1RqXDdsHWuyZXfPITXFu5R9sIRvmwUUpMTm6fJ2uV6x0f
 hUK0LE9H0VcSIa.GCLARokBhIbP_IHIb6JWQFFuZ.RijQS6ved2y7ihiML9zqo7xjLqdYUVNgR65
 QWeKiuUCCDBz.wzSG.0VVwxzdDxqfJiFCbN2wxyoXydQngNifG0w0LHuq4ZLooW0Cb.jkCg.j_md
 d7q8E6euY4F8dfZCsarSMBQaIolZ2xvWY4Yv6YywUoLHiv9yRXltQ6fcPu6ufpXD9NgHg_2uRxFx
 g3dr.oqUzPtanZlDX3lH7_SHkBL6Cw71KRB4ebl6TQrODqiV_hQg.J4a8.0h2fwX3PbQU4wH75i2
 c6rDlOE15_Wu4UI38MmY9AbzCmki7NA_fUaxUnZkYqsQhh64_YMNBmro3Tn2Izfjv_Pv3kD6t8hF
 LPhpfDd1GC_IbJcm2xLAm0CWustZAJJDYnSF9NjxxV51p1jCFoMynbhCtQbayhlD6exxIflJAgv6
 8mWvRnilpbTGnOWyUq2MZue0m1Je1l4xl1cmUIOheK0gQOwVP5z579CXD4cqV3hXEVbVXkFVJPr9
 UwrYjJjlMk8pvcEydXFkmFanoHumQFjSLMoAcA434FGBI8QZ_XnZUziMBEuUd3QfbFi4_r.7yP0y
 migsy4vntj9BzKOM3NSjvd8BhhuK8oHXeWPY6WU83egrvMqHD4LEMXpMiHuS6jy4ZFHWzzY46UdL
 Gsr37lRG14pb3DeD_6kvAywGCApl4OTMC3bg25DNc_ptvJW.cNuXkJHMGEz.OeYbYsu2TCIBOmrx
 sewEg000ZlSm3ZYf_5UYMoRwqCYlaHYH3cmc1lr5OVbBYX.aEC69eVWuN6Ygz8mAzt1AmYjM.W_G
 z5PTfSOX6
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: 2221c130-951c-442b-8f24-1cf1de7e99c0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sat, 22 Apr 2023 06:25:47 +0000
Received: by hermes--production-sg3-6d6fb994f6-2fxf8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 35524fb850072bd71f5439af80185d30;
          Sat, 22 Apr 2023 06:25:39 +0000 (UTC)
Message-ID: <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
Date: Sat, 22 Apr 2023 14:25:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: hch@lst.de
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, jason_a69@yahoo.co.uk,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev, robin.murphy@arm.com
References: <20230416065503.GB6410@lst.de>
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
In-Reply-To: <20230416065503.GB6410@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Christoph,

Sorry for my late reply, I have been on the road.

So, if I boot with
intel_iommu=off
Then the server boots fine..although that is not a solution because I 
need Intel iommu for virtualisation.

Also, I build all my kernels with CONFIG_INTEL_IOMMU=y

