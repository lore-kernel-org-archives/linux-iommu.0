Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C429B778
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751582; cv=none; b=tZ1Wrf47dNqiAUUTiqa2XR/EsiJ29ADpQdluXVwJWL4jdQ4CAbQd29OoT4PLVo9/ZOW/tkzJFy86JkL4c84amh2OZ+Y0TnHae7BZ+0M31u3pzaPLkzu+Cr7HNz1bzwNk2j3kS4p1rBihquM8K38Cg0WheJ2v6mtq5ooYwlLlgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751582; c=relaxed/simple;
	bh=+JL27+FiggSb0VhPoQSBWCZ+OGPNrTMX7uEbUWMGIl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arvoxlpxox1t4BX53LH6yXx0gr22fFZO5MGJ5LAcS3q3B8XndImoFjBUTzN6FiJrp9b5Y3CXQOsKSDU/74MbX+UmYfpqBdFFx5awLIRPPYR++arQiHOc7svt0PE4iX9WweADnkJPqlZVHlOEEn3QL+ylsIgUceAaufpjebGLnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sR2i62oh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sR2i62oh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bddba676613so4054516a12.2
        for <iommu@lists.linux.dev>; Wed, 03 Dec 2025 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764751580; x=1765356380; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubn96hZCY6OuLzYZcN1v+Qbk5qXz2YwsDlmONqQGhII=;
        b=sR2i62oh8rL0CDYZCXlWCYHX7BZaof6RbSYV+MJGvdqwq09Ft36duAW/l6jR1gX9FD
         fUEWA7thCKoEOoeM37EGgiMIj1zYkDs6+wpmkZTkCqZ7wMadpol/bjlprXZulJk3VXTA
         v0GbxQYbV2PFHpdNNW4VwrbRGLymJtVG8dPfuP2cj7bxNv1Y3MlNpyaJcwSA3Qnh69Ms
         PsvCil28f7tcZjqOZ276qxSXGrBCY+aYM4uRHMFwoPg5sRxEIedA1Fu/K7DPIMzOIKrc
         I9YrB4M2k3Gr6DSkdnV0irluzq/knsNKNvPiRX8Aa9Lcl8IGsYrTgbGSSvHWaOstdjDc
         dJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764751580; x=1765356380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubn96hZCY6OuLzYZcN1v+Qbk5qXz2YwsDlmONqQGhII=;
        b=UUixAtYl6i3ohpnjALGtEhWN18EMaJRjlGGzGiTk+sdm0d2rUBacDePpuJ0Vjf2IP3
         BREa2sREFWfS4dOXS5EqgsiVyOtuEpGlYJtbvMhce4J/YGZLnrnsMbogtkFmjbU0Nwzr
         ev8ZBrm6l6YACrqs7bJVVUfPoKYWXJEhv93Of8HF8OsAM4ftq9eiJ6GShKMRjn9gkzro
         JsmP7HooYEHmi/cCafT/rJZkzpbFqQTKtmQOsBOiSdRJFu5XJNEJr0n42J3NRVDHWaRl
         n/GKdH0saGJtW6JlTDRyQ22jgeDQVVygnXymKo+zTZI1KiFJx+C+j/lw5uBYYVwjVJZV
         WgoA==
X-Forwarded-Encrypted: i=1; AJvYcCWA26Wf1sfN5FbFnquDg7Fs0mTMEld9TeGiWpJlVYcFAC3dZHYu2ltgpaAkJQ2d3AR0mQ+BOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCONiOjbpGQgDJiB1pQK4tkvKnG3+sW32tqOPrt8GdDCuRHgv1
	47IhROAjklssn5m+582HEsyll8bNYXvuDEYWkNbSF2T7WHsZ2cHt3ppawl4Z7o4cgf8t6hiXOoA
	IsSveWX6XE0jEm7MMyOKTx+2SU0PUd5Z2wiyAthMjfw==
X-Gm-Gg: ASbGncuWDMFMat7FCNdOli4emm2FibSg8F8Sz7SrFsKGbMJjHXWva9UfSuAxkYgXPXS
	i/5JxvOB7knUzBBXHXtKfliIamiLQJlzkYe3MajF9d7mR6/NycCmzv/7/OCcRdAojEMaY25AMCY
	TD0ReFOxn6cmtdmRTxjphdqOHqmpSyuZSn4v6QOJcz4rZrVDnXrFSqT8YDENopRVUBnocUQJc2k
	XeIK+j9dsJxKgZBDX/1umS7zvpbXpo/MTTMkXQjUEbfJwt8VRC+NAao7SsBnv+e4O+F2Wfk928s
	ZFP6xuXGZ4chxs+GgHDrmmr4fawe
X-Google-Smtp-Source: AGHT+IESfyz0WvcdLg5zso+cF/spjXjFo7mPapRZnsru8lI4xWV9asxUh3P8AuvahqHOyEhQ7GV0QrnDc6g77E/4q1Y=
X-Received: by 2002:a05:693c:2285:b0:2a7:760:2b61 with SMTP id
 5a478bee46e88-2ab92da0fe1mr1128392eec.3.1764751579599; Wed, 03 Dec 2025
 00:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Dec 2025 14:16:08 +0530
X-Gm-Features: AWmQ_blHL_iDCylpGXX4vpPrEWS5hqhh9zdpg4OOEAJju8Mpzrh8qH6Yoml_Sl8
Message-ID: <CA+G9fYsLjKov93zsZfPovVmfEus6QzaVd_QvCYtmqMn+kY+6ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: Fix ACS enablement for Root Ports in OF platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 19:53, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Hi,
>
> This series fixes the long standing issue with ACS in OF platforms. There are
> two fixes in this series, both fixing independent issues on their own, but both
> are needed to properly enable ACS on OF platforms.
>
> Issue(s) background
> ===================
>
> Back in 2021, Xingang Wang first noted a failure in attaching the HiSilicon SEC
> device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
> ACS not being enabled for the QEMU Root Port device and he proposed a patch to
> fix it [2].
>
> Once the patch got applied, people reported PCIe issues with linux-next on the
> ARM Juno Development boards, where they saw failure in enumerating the endpoint
> devices [3][4]. So soon, the patch got dropped, but the actual issue with the
> ARM Juno boards was left behind.
>
> Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
> hoping that someone in the community would fix the issue with ARM Juno boards.
> But the patch was rightly rejected, as a patch that was known to cause issues
> should not be merged to the kernel. But again, no one investigated the Juno
> issue and it was left behind again.
>
> Now it ended up in my plate and I managed to track down the issue with the help
> of Naresh who got access to the Juno boards in LKFT. The Juno issue was with the
> PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
> Completions received for the Configuration Read Request from a device connected
> to the downstream port that has not yet captured the PCIe bus number. As per the
> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
> supplied with all Type 0 Configuration Write Requests completed by the Function
> and supply these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests". So during the first Configuration Read Request issued by the
> switch downstream port during enumeration (for reading Vendor ID), Bus and
> Device numbers will be unknown to the device. So it responds to the Read Request
> with Completion having Bus and Device number as 0. The switch interprets the
> Completion as an ACS Source Validation error and drops the completion, leading
> to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
> 6.12.1.1, states that "Completions are never affected by ACS Source Validation".
> This behavior is in violation of the spec.
>
> Solution
> ========
>
> In September, I submitted a series [6] to fix both issues. For the IDT issue,
> I reused the existing quirk in the PCI core which does a dummy config write
> before issuing the first config read to the device. And for the ACS enablement
> issue, I just resubmitted the original patch from Xingang which called
> pci_request_acs() from devm_of_pci_bridge_init().
>
> But during the review of the series, several comments were received and they
> required the series to be reworked completely. Hence, in this version, I've
> incorported the comments as below:
>
> 1. For the ACS enablement issue, I've moved the pci_enable_acs() call from
> pci_acs_init() to pci_dma_configure().
>
> 2. For the IDT issue, I've cached the ACS capabilities (RO) in 'pci_dev',
> collected the broken capability for the IDT switches in the quirk and used it to
> disable the capability in the cache. This also allowed me to get rid of the
> earlier workaround for the switch.
>
> [1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> [2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> [3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> [4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> [5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> [6] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com
>
> Changes in v2:
>
> * Reworked the patches completely as mentioned above.
> * Rebased on top of v6.18-rc7
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>


> ---
> Manivannan Sadhasivam (4):
>       PCI: Enable ACS only after configuring IOMMU for OF platforms
>       PCI: Cache ACS capabilities
>       PCI: Disable ACS SV capability for the broken IDT switches
>       PCI: Extend the pci_disable_acs_sv quirk for one more IDT switch
>
>  drivers/pci/pci-driver.c |  8 +++++++
>  drivers/pci/pci.c        | 33 ++++++++++++--------------
>  drivers/pci/pci.h        |  2 +-
>  drivers/pci/probe.c      | 12 ----------
>  drivers/pci/quirks.c     | 62 ++++++++++++------------------------------------
>  include/linux/pci.h      |  2 ++
>  6 files changed, 41 insertions(+), 78 deletions(-)
> ---
> base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> change-id: 20251201-pci_acs-b15aa3947289
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
