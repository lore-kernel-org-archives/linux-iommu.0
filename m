Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21710E4
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 12:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFADC433EF;
	Mon, 27 Mar 2023 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679921528;
	bh=+oGTRnEoL+r8hBNjvZkl//nS5qY4v/0hb8ajVYZqqrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwVjAoyPQ9X91nnjWlFdENRtb6qTKQHKVeo4h4Wh2WHghskh0jjPWhGQ8GTtX8mOo
	 G8w9JVz9tvF6pFkf3um667v2v0th/RJVRhCXa05E274dem6N5BtRVKvDX2NDN05JlK
	 JNcT+SZ6C3wPH03RbIhcNPiG1dNZfgsV73uQNDCtxdRrA4SzzOpfGf+F9z7wWB1yi0
	 RIdLnY/WRf2licJ7R4Zn+UooYn75ZMj0SLmOnFFn5Lrg3Uc9N0fqoWhWM3a8qKsv++
	 PCyArFkiWTuzvxjKmROFy78lfw3m5jIk8sEYu+oL2zqb5sf8WRWxndFnxkFgaJMDEi
	 wc2ztgM/wpmhg==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Explain why ATS stays disabled with bypass
Date: Mon, 27 Mar 2023 13:51:58 +0100
Message-Id: <167991974381.1304864.1584652149042619727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230321100559.341981-1-jean-philippe@linaro.org>
References: <20230321100559.341981-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 Mar 2023 10:06:00 +0000, Jean-Philippe Brucker wrote:
> The SMMU does not support enabling ATS for a bypass stream. Add a comment.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Explain why ATS stays disabled with bypass
      https://git.kernel.org/will/c/8c153645fa40

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
