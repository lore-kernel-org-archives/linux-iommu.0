Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49A33C4;
	Fri, 22 Jul 2022 14:39:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5A3275D1; Fri, 22 Jul 2022 16:39:43 +0200 (CEST)
Date: Fri, 22 Jul 2022 16:39:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Will Deacon <will@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] drivers: iommu: fix clang -wformat warning
Message-ID: <Ytq2rYkTMyzdF3Lt@8bytes.org>
References: <20220721210331.4012015-1-justinstitt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721210331.4012015-1-justinstitt@google.com>

On Thu, Jul 21, 2022 at 02:03:31PM -0700, Justin Stitt wrote:
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

