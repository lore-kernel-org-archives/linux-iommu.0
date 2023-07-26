Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3901FD0
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 03:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB35C433C8;
	Wed, 26 Jul 2023 03:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690343612;
	bh=RMr8bRzLunRxtCrJQOL6/k3E088XGswEuiJqIShjTck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eREjlYaqD/aAAXCBw18NEa45ugyBsTiwP49e89Rd7Jba3DQEcvKYLhkF9Itrgbkr5
	 HLDXC3vgLBOkNj/RWI7gm0LIKj7rhbKCujeU4xqPIEiyDUC6RMqWtFEuCnqMlWVksV
	 hK83dE0mj8aJu2SxMc5JNNtwjUgQeJe9wwEgVsdk=
Date: Wed, 26 Jul 2023 05:53:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, stable@vger.kernel.org,
	syzbot+7574ebfe589049630608@syzkaller.appspotmail.com,
	Terrence Xu <terrence.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/3] iommufd/selftest: Do not try to destroy an access
 once it is attached
Message-ID: <2023072608-foam-impotency-04e5@gregkh>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>

On Tue, Jul 25, 2023 at 04:05:48PM -0300, Jason Gunthorpe wrote:
> The access must be detached first.
> 
> To make the cleanup simpler copy the fdno to userspace before creating the
> access in the first place. Then there is no need to unwind after
> iommufd_access_attach.
> 
> Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
