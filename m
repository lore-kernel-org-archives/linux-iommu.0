Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4C22E406
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569357; cv=none; b=GusoKmKo0cQLgNmlIYazarQhpi1/kViXINd76cwDaBLM8hU9+ds+Fd56bjhjIDKlUmjFzE6/dK1bgAniDzXs6QSLb7W4+Qhs/byuB3i5YQ/SQSIs6mNBEs+p8yudPMjGm0QPcIibKO3eRlqdSYUJI3hClexKJzRplIzqcf+DVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569357; c=relaxed/simple;
	bh=2c/2TGXe1TvOXnyySJnc/eJoic2DVPnvVTIFzQKKPVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIJg6skhjCJFgmZqJH/y/SdEDZ/qiWoO5A/BUsAG6cPgwV2NqxbS04La6VEVL+wInzdgQ3P3xECXBDb+sK2C4Ai0Fjg1efEdvbrL4cakUMrxER3NwvCpkr6FLvUDH2hMpCsaWyoSuyr/tTREjowlmUNxs6sFWa+nVssRuF6NRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Q1tSslCY; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Q1tSslCY"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F7E5598F5;
	Mon, 27 Oct 2025 13:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761569353;
	bh=2c/2TGXe1TvOXnyySJnc/eJoic2DVPnvVTIFzQKKPVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1tSslCYQiIrLVNZDVV9VcYf6zV0LJhi9qCYpcj0H3ZdhSouGi2+QELJrlmjNLCK4
	 /WyUGdhhlZzsJoQ9LKrzU6hkjZh+n3+ybFvYreGGNAr4W3OmipqTqFIYfOXdeWwsCy
	 ECvijRprBOK4F4WC/2gfPv6+nBjqQNQyfpa573u1zbSfvMDyeAXvps/GJXZqsCY0YK
	 NC3B8woZBtlovRXWE0BduYtNKAipwUFNuHa9KcBd7RTucsbpdGGR1sa5OyqrF/gBR2
	 YxsSf2jpEVYGRdjn03FoVze5ffaA9O/4424HrNcUsmcDRMeUWbBaUQN0mdWagjz/QR
	 SZPW3tiyy5Fgw==
Date: Mon, 27 Oct 2025 13:49:12 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
	Santosh.Shukla@amd.com
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>

Hey Dheeraj,

On Thu, Oct 16, 2025 at 08:38:09PM +0530, Dheeraj Kumar Srivastava wrote:
>  static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  {
> -	int i = 0;
> +	struct iommu_cmd *cmd;
> +	int i = 0, j;
>  
>  	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
>  		udelay(1);
> @@ -1166,7 +1167,33 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  	}
>  
>  	if (i == LOOP_TIMEOUT) {
> -		pr_alert("Completion-Wait loop timed out\n");
> +		int head, tail;
> +
> +		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
> +		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
> +
> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));

Better use dev_err(&amd_iommu->dev->dev, ...) here.

> +		if (!amd_iommu_dump) {
> +			/*
> +			 * On command buffer completion timeout, step back by 2 commands
> +			 * to locate the actual command that is causing the issue.
> +			 */
> +			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
> +			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
> +			dump_command(iommu_virt_to_phys(cmd));
> +		} else {
> +			/* Dump entire command buffer along with head and tail indices */
> +			pr_alert("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
> +				 (int)(MMIO_CMD_BUFFER_TAIL(tail)));
> +			for (j = 0; j < CMD_BUFFER_ENTRIES; j++) {
> +				cmd = (struct iommu_cmd *)(iommu->cmd_buf + j * sizeof(*cmd));
> +				pr_err("%3d: %08x %08x %08x %08x\n", j, cmd->data[0], cmd->data[1],
> +				       cmd->data[2], cmd->data[3]);
> +			}
> +		}

I don't think it makes much sense to just print the command before the failed
completion wait. In case of a timeout and amd_iommu_dump == true, just dump the
whole pending command buffer, from head to tail.

Also, please put all the parsing/dumping code into a separate function.

Regards,

	Joerg
