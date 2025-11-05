Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFE2E1F08
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377726; cv=none; b=GD4CAF9QOIElN4+LQVx3tIoLPn8VWuZY9CZk11eJsasnSP0EHHOqiwcxiB0WEBX18Ktf0r9IJ+IFR43Rf7z9phCZ1yMAunQ/lPx1BVmw5z23jhqzllPLZgUBH00McDoVTOxyTZQ3YieuY23SOpa61TzkimKorXx/cfknFXVtUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377726; c=relaxed/simple;
	bh=o0O19Szr2FQYPaYkftbuT/fcTYOccrWu/+zHI4bfRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geFI2qU4nW0Zt+xe4IAj7wC/Hqzsk8mysmhVIQXDXaMfhtzlA151G2ZWD31HH+4WMg1zIB/w1oTdmn3sH9+rD0SM58t0TpUB6kyyfSuAIiMGB9ingtrYdf8VIWtPsSXzZLAqGXxgPFO4BEM7oH2rE6X+eEx2efGpnbfuzZNuGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O/FsSwO9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O/FsSwO9"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 731C7211D8B1;
	Wed,  5 Nov 2025 13:22:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 731C7211D8B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762377723;
	bh=/yyzbvKWkxQn33B8KRC6XD6kZsWxcgaTQieHG79mktQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/FsSwO9TS+Gl4qEN7q3I9mSrMlpVDCQc+WLHtY2NCE6bjSzEA6IEkWVaBXqfYNRw
	 cx+Lm2M2uSBgKgVp6Gs5NSt+j2Njp0kr0pU0WvAXX81tOJoDiAUoWUVoXhhTLM2Ho5
	 VZpc+chcpUYLPt7oalIS09rWZ2HKofbtvKNZ82/A=
Date: Wed, 5 Nov 2025 13:22:01 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251105132201.00004a5d@linux.microsoft.com>
In-Reply-To: <aQupGR8QsS2h7xY/@Asurada-Nvidia>
References: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
	<20251105190638.23172-2-jacob.pan@linux.microsoft.com>
	<aQupGR8QsS2h7xY/@Asurada-Nvidia>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On Wed, 5 Nov 2025 11:44:25 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Wed, Nov 05, 2025 at 11:06:37AM -0800, Jacob Pan wrote:
> > +	ret = queue_poll(qp);
> > +	if (ret == -ETIMEDOUT) {
> > +		dev_err_ratelimited(smmu->dev, "CMDQ timed out,
> > cons: %08x, prod: 0x%08x\n",
> > +				    llq->cons, llq->prod);
> > +		/* Restart the timer */
> > +		queue_poll_init(smmu, qp);
> > +	} else if (ret) {
> > +		dev_err_ratelimited(smmu->dev, "CMDQ poll error
> > %d\n", ret);  
> 
> I don't think you need this "if (ret)", as queue_poll() returns
> either 0 or -ETIMEOUT. And the patch that I shared with you has
> this noted clearly.
I agree it is not needed for now. But in general it is more robust not
to assume return value never changes.

I can delete that.

Thanks,

Jacob
