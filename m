Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F0436374;
	Thu, 22 Jan 2026 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082773; cv=none; b=CTHN7Ym3Ytldinlr+qtcKT96t/oOz2n+HM+LiryrKWKqqd/qvoNn1hHdRtXLoWC4S+eS4JdDf1q/Lef1oLVwRxEUwpHFQJruJyf/miNw4x9slDlvOAgIFpa2ROPaaFXWnATlbVGpmMQuIujONrTUK9bKK4/ehwlRONM2GlQpuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082773; c=relaxed/simple;
	bh=8bKk78/cUBVMRsGmIHB9eHx8NN7HqTjyj+NpF8y77Vk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tVvgyGA5WRpeRF3E4mpjbUEULX3Vx2x8lPy8sLLdKOeFfCT2w97l3KnBPbUeO4f5HJq8F/G2k8SjT/psSrQeKmNBhyHyi0oU6jHTj6lwFPfVUTXWWRamATj0cWeVXr194veRdzVJIrStAPUw1cSdv/HsXqpxzbHxq2JtQS13QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKFhd6eJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKFhd6eJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85833C116C6;
	Thu, 22 Jan 2026 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769082771;
	bh=8bKk78/cUBVMRsGmIHB9eHx8NN7HqTjyj+NpF8y77Vk=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=WKFhd6eJG/25Tu4S4NiFeifgs5vRUp2FvhIhO9DOqZHowGyVhBvqgg+aZaszjdrFy
	 n8ifSpsyn0O3b7M/uwQxbFTWBoIGqFRrA0fOKwQmHJfBSJKzPzpjU35UML3nFzwV3d
	 h1HO3UU/PT6kDfE77KwS+bMvGFQe9bACXaz7I9U4odtNTE0CReW60VkX7xP9WENuQq
	 oZejainJFYp9vFSx8K4TusF1lRA37G6EGikufyzZTh33VEHyqTfkDKkn/yRepN++LK
	 kbVe0vhEaP7/NZeO5EYTlnbJr7dV9TGOu02iQc9ozWBuabmlwKqMhPgDHI0Yb/cZLj
	 gaR7SJwmgt8gg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 12:52:46 +0100
Message-Id: <DFV3I3D5UIZP.38TNCAJWQGI3O@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <broonie@kernel.org>,
 <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <robin.clark@oss.qualcomm.com>, <hanguidong02@gmail.com>,
 <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@oss.qualcomm.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>
To: "Ioana Ciornei" <ioana.ciornei@nxp.com>
References: <20260121141215.29658-1-dakr@kernel.org>
 <6oogrqe3n5sxtpdydjqo4ucwp7n3ipqoupxtekvzbnqd7dae3s@q22wc7fpbtya>
In-Reply-To: <6oogrqe3n5sxtpdydjqo4ucwp7n3ipqoupxtekvzbnqd7dae3s@q22wc7fpbtya>

On Thu Jan 22, 2026 at 10:21 AM CET, Ioana Ciornei wrote:
> The boot lockup was visible also on the NXP LX2160ARDB. This patch fixes
> it.

Interesting, this means that qcom_smmu_impl_init() must be called on this
machine, is this expected?

> Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> #LX2160ARDB

Thanks for testing!
