Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BB3E8C7D;
	Thu, 22 Jan 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081144; cv=none; b=TaZucLD05Kwde7FEZU3DqVto46Me9YQs/BlJp4XU+Dor/f3alQDSthax2Nk5mrPEw4l2jMSacdX9DkzrT0tJxIWIMEFbPAvpCpUnybaS8WBr8IUBGKfSXf1I9oXjrD6/scEHnN0j3/fpTx+sfRfWw40hh8zqIaFNtbiAJDnMZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081144; c=relaxed/simple;
	bh=rB6oVz9be/E1Ki17Rez7m48bfgIZtYeVWggaFcuAcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8IocIpnamQ9svgk7tD7WuYAVNyn/ZTrGkCjp8saq5HcJ5dKMuI8PG0Ww2he+vuVSR2ie6ABqCFZElz00GBiXap89Qqfh97ZwUkaWqEK9Ksh+KWPueUA0K/XFOhfiAP7x6ONOAG0RbGNesc+Fs7sB+L6DDcbyTjjcZ1I6/ILPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL6Fd35I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL6Fd35I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56207C116D0;
	Thu, 22 Jan 2026 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769081143;
	bh=rB6oVz9be/E1Ki17Rez7m48bfgIZtYeVWggaFcuAcDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iL6Fd35IcopbUCLSakYEU6NDu+RELMzIoVWs2RAcJ/NcpUL4ULxqV355DiXkQCKkr
	 X989YsUZnYgdLsaO0KFoHBAzvWvZzHeQgIfF2eICG8gSs6jZkASHmEjJeIk4PIKM+a
	 Q9Er+qpmLt0ymtLpdZIYV5tZuGzwlxdp+TMMocn7n83OZz58n5S51x1CsZ3BfCoiWN
	 MW8cyAxqZEEdKKXoI686cG5UITIs6v4uMwBqIJWedVyfjsKJFo9i2nlgKANJWKoadt
	 1ETA0FvOplm/LjrZjKb0oZOicANezz2dRMrCQq3N2uDq6EPYFVwgSKyO0xP7jXvhGk
	 fd3XeGLtDpDyg==
Date: Thu, 22 Jan 2026 11:25:37 +0000
From: Will Deacon <will@kernel.org>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	catalin.marinas@arm.com, charan.kalla@oss.qualcomm.com,
	iommu@lists.linux.dev, joro@8bytes.org, kernel-team@android.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.clark@oss.qualcomm.com,
	robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on
 sa8775p
Message-ID: <aXIJMRcfuJwi73iz@willie-the-truck>
References: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
 <ctdfmzictrjcwugv66hmk5pouj56qviy5umdo3yrmhvfexqoni@kmtozbt53sdv>
 <5a8fc32f-0a4d-4b76-8093-faf9207a4938@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a8fc32f-0a4d-4b76-8093-faf9207a4938@oss.qualcomm.com>

On Thu, Jan 22, 2026 at 04:52:10PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 1/21/2026 3:56 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 20, 2026 at 08:41:05PM +0530, bibek.patro@oss.qualcomm.com wrote:
> > > From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > 
> > > The ACTLR configuration for the sa8775p MDSS client was inadvertently
> > > dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
> > > Add actlr settings for mdss on Qualcomm platforms"). Without this
> > > entry, the sa8775p MDSS block does not receive the intended default
> > > ACTLR configuration.
> > > 
> > > Restore the missing compatible entry so that the platform receives the
> > > expected behavior.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > 
> > Missing Fixes tag. Otherwise LGTM
> 
> It looks like [1] hasn’t landed on any release branch yet - it’s still
> only present in Will’s tree, which is also where the referenced “fixed
> ‘commit f91879fdf70b’” SHA was taken from.
> Given that, do we need a Fixes: tag in this case? and should it use the
> same SHA from Will’s tree.

I'll add it when I apply, no worries. Still playing catch-up with patches
:(

Will
