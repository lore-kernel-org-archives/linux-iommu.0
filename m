Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB289214E0
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689177755; x=1689782555; i=markus.elfring@web.de;
 bh=8+0MnPSuI1T+Jh5E4Y3V47X306E0vN4CD6UVKoA+v+4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=vaJ6GWEC1NKBuzqrAbF+Cj88lJcGFIQetevGBC2DNr1hmX6PkrmRiFavXDnfMPx6bHf1R9Z
 YSDSHfPaS1kG4Om8pjb1y03hqmCtAoqiLZ5smlW4NgPZqOdUw92+F/BZZXuReakTw7UQck7/h
 5si1GCbG0BAcPnmqSjkNPxJ8riUMXdz+fheBaZ4rOKpnYGbEbcksOpCiHzbLHZOuqXtONiomb
 Jd64Ut5x6k7Dxuze1/yZP0422a2sRyv4mYz0gZMHXTBPTsvDCKxAs2eHv2sT6H7RXjDo+Idzo
 F/7R16PC7b+0GKNsMzaJfIefKUw2FBBgI8Ixfd+6eOs+R5/yeQ/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1qBP651ae6-00HaDl; Wed, 12
 Jul 2023 18:02:35 +0200
Message-ID: <8aefe246-cdfe-dd39-924f-50d528ccfc9c@web.de>
Date: Wed, 12 Jul 2023 18:02:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Thierry Reding <thierry.reding@gmail.com>, Minjie Du <duminjie@vivo.com>,
 linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org,
 iommu@lists.linux.dev, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <ZK6a-f2Se3HWjU7D@orome>
Subject: Re: [PATCH] iommu: fix parameter check in tegra_smmu_debugfs_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZK6a-f2Se3HWjU7D@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5YFLuCrCf372MkimPictFqdRBFOguxm5v8OeHfBBRwUXClrNVkC
 bSHi1eqpmWp3NtL4hf9ppTJelUmvWl9iDCOPg0bj3dy8eSC8U3A/x2cuEfTKS8NIDDPr5e2
 tNtAuKQ9vj3vmKZQ1L9AXdX8klVWkO7VbtofiMCN/lLNDbe9mSwMJUpFGWxEKsUTlDaFozo
 2alHHAF1SjToMc3WjtR5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wvp+ud0ZOaY=;bKfbLc6ftVJaOC8OtCxoqSk8Ucz
 JTw+bbLLzD5913E+wVp/gJuQCifi8SGxDtLp/dbqtxqELOupldR3gnmEKKg8Kk0nfxMx75396
 006aiPGMxd+0+Cl1TzIgCKPFvLMwcGE6hjgGUsQP9MPXEZdZs9z+inGzR3RBiQeMQZBtQmCXg
 kXNQM1pzRkAnTgT72omMIOYRQXZgs+8CnP6bEeWErJs5F849ZwG91PUlvGhJBuAjz/WTfCmSn
 APuk2ehd+XkC6VokMpPhCCBmq/dzzn6SdeVk5qUlhjbTrtGEt/jPDCnUf+5zIZPD60H+L9AK2
 Ygdllw1VJNBzDN56xvDNlqwGSUjzKoOTGFEe5hKwo6VSq8q66T85BCk3GAeyPzPkTnIREbYqL
 0bqL9tXoWeprHkLdquuLnava2V2+9yfiZ6F7kX5/B666BxIXX3zvyBTfoqVMauGVDdIojwqck
 vNgbOFj7sUCKUweYo9qax9WVCcjFhrcmXyPHKhIf+uB6Q7mF09FBG52lojLegR0hI3mzGGM/1
 ahLeyWq3WIfFCTHamEZTDc5OMRybOGVmSeoDmIZ4O11+84qrwnTMUKi0vcnL0i6R5BHW11wiB
 yX5LSrk1N9D0/l3nh/vg8qrXera1otBpE+wZ22DVihXqOSLFecbyo0+jcUmZOkSoARFWkmMi5
 BC97XIvy3MW+8PdSZIK3PHPA1YjkAyT6VLuYx55NAODN0r868XTTMjW/gXXam1QC0zyGowxii
 oHECX1ToV+QW2b52CwPzGo4fbQLTx/8CKAUMfPwti+Z0HKGEjs2d7AyRqmpaQZGcCd9oQ+mT6
 2s/umURNU6xLebxJqruU3K2UNOh8wJd1Z7o3aGqPCjWX2UIfzQvDl5UMCHuSskxOnq7FX7P/W
 Uj8SM0v9zK7mX4Ux24krOEZ6F9uVuBo2UpaQUCEbdKazVOR+1A3jBEJpjd6qk1uJgmRs7IYpR
 yLRtRA==

=E2=80=A6
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> >  static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
> >  {
> >  	smmu->debugfs =3D debugfs_create_dir("smmu", NULL);
> > -	if (!smmu->debugfs)
> > +	if (IS_ERR(smmu->debugfs))
> >  		return;
>
> I think we can just drop the error check altogether since
> debugfs_create_file() will simply return early if smmu->debugfs is an
> error pointer.

I find this explanation confusing.
Can consistent error detection matter also at this source code place?

Regards,
Markus
