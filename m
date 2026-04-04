Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBD2D3A60;
	Sat,  4 Apr 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299847; cv=none; b=M9YPcbVyquwzEjj/EDLnbd6LQO9Wy0XQp1thYRA90sE1Ur4ZFaR/fNqH51jXIrASR8eWMntE65FuPexVBkyP+YaDrqgCX1P8KT0Fk56BqKJIU0G0Xk3+Q9adN2Np7xuunY47wxF30hvM+3kvKK9AI4ACGp6ZbNFC6FvF4SYoVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299847; c=relaxed/simple;
	bh=XlV93qt8XxCZGBNC86/HRqHqRPWS0RQnPhDy2NL8/VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9knnBisWSFBo5CdzMiWltYGlRd8ZHlkL7sBZ89HtiAbpD9pJmkLn+r/K2BZqoxfK10l3niilwRURjzZkfoO+m6xsU2j6ie1xf9uxAPUvz8EG1aRfLxecdlWgud5YfXq0Xa4+6MWVs/TLDhGzqScwsPbpM9qaBR5A5NHhDA7wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvy7ergd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvy7ergd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8484C19421;
	Sat,  4 Apr 2026 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775299847;
	bh=XlV93qt8XxCZGBNC86/HRqHqRPWS0RQnPhDy2NL8/VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvy7ergdvQvaay7kV3qQWauJcg/3sL8wHUNwYoHNmuMOtWWZT+CSy8fzUdoAyj5XA
	 im6n5mdOd9xfLx0XSwv05Rac5aRpujCigBYkNPphd0uZl5Luz9tgz9RLcaq3u6l7uN
	 daY/acphESIcmLfti0Ic3e37xelWgO9E/gZ0suYA3pdPPEugWQN+yT7SlI/UxTURD8
	 +iuoED22jDHZ07XsD6OYydgo8c/lO8DDgdp7+p11E9UZMn+5GPA4Yu7sqKjgZKQ33g
	 NW0PFWPLMO3dMo6iVbc2MzT5lab25QJW9f+xMAjcryQ8z2WdK0MmVkoOhMBJqd94KX
	 qJRrKYCIYwEnA==
Date: Sat, 4 Apr 2026 12:50:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: Add compatible for Hawi
 SoC
Message-ID: <20260404-hissing-determined-doberman-fa1ab6@quoll>
References: <20260403080956.2714415-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403080956.2714415-1-mukesh.ojha@oss.qualcomm.com>

On Fri, Apr 03, 2026 at 01:39:56PM +0530, Mukesh Ojha wrote:
> Qualcomm Hawi SoC include apps smmu that implements arm,mmu-500, which
> is used to translate device-visible virtual addresses to physical
> addresses. Add compatible for these items.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

