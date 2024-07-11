Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6021158D7B;
	Thu, 11 Jul 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695296; cv=none; b=q3XqX5H9P6KAPK/RTCjeQDN+uAMf0b11HZGbuYd4vt3mO5srrgcZI25NRomKoVYDQp6wB63QaNo4938qnOuBYzrZ4C3zlXUYW3jan2VCoYwt78Xd76sR6KusCrWOK6FEpqrgUP4zf3KTacqkYZZcyGdrArstQqV0wBRVTjcl74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695296; c=relaxed/simple;
	bh=+5MOnTxYxBjQT8+zbsn3fUy0MmdPvi2NoRdT1GIMQIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1m5OyHBfUJXkYLDOUqxYLbRpYFLykueEpk23OXqn0dmkIc088hpvFLaGofMqXPobn3agQhO7JdBM35m/TsPbg7EUCGRyVLvCzhagrh5GGquC+/wu0Xsy8/LfGGgqZZh0dYJ2W2McFXEWudK9HsW+smHMr7EN91bMxVSwDSW7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBNS58GR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBNS58GR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67DC116B1;
	Thu, 11 Jul 2024 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720695296;
	bh=+5MOnTxYxBjQT8+zbsn3fUy0MmdPvi2NoRdT1GIMQIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBNS58GRCFb38fxFaHhOuvn7AL70yVYCWdVktItxjbG3MNyvYaoDk2GVyEOce0Epm
	 2yAj0qAbi6UZuXVWQwcDw88M2OJj92o93nmsURkIkOYxUDqkyUaTBc3Oele57QW89x
	 4xwJHY5iS6DrGzrb40jvZU2NFjr4TJ3NHPQTCFvCqnao9cEiEaI+siQxm3x5nXeYfX
	 ypqvhgNOsBAdJk7ip8ZDVByzUcEe6EJg0/I7BexhpjcB5OuVWloVWlhZT2Gf10ghdC
	 rKTN8a8s75qDabtdw0uYPpYMaC/6LhkdBesZYLOJID2zTzsiuisvj2yykCWCDTHlMN
	 RX1WdL3YfYfLA==
Date: Thu, 11 Jul 2024 11:54:50 +0100
From: Will Deacon <will@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document QCS9100 SMMU
Message-ID: <20240711105450.GA15335@willie-the-truck>
References: <20240709-document_qcs9100_smmu_compatible-v2-1-599161b7d5c8@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-document_qcs9100_smmu_compatible-v2-1-599161b7d5c8@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 09, 2024 at 09:39:29PM +0800, Tengfei Fan wrote:
> Document the SMMU on the QCS9100 platform.
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-smmu-500" to describe
> non-SCMI based SMMU.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> While the QCS9100 platform is still in the early design stage, the
> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> mounts the QCS9100 SoC instead of the SA8775p SoC.
> 
> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
> all the compatible strings will be updated from "SA8775p" to "QCS9100".
> The QCS9100 device tree patches will be pushed after all the device tree
> bindings and device driver patches are reviewed.
> 
> The final dtsi will like:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
> 
> The detailed cover letter reference:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
> Changes in v2:
>   - Split huge patch series into different patch series according to
>     subsytems
>   - Update patch commit message
> 
> prevous disscussion here:
> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Sorry, but this doesn't apply against my bindings branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings

Will
