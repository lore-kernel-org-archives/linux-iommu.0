Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE2187F
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 14:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C7C3411C;
	Fri, 24 Jun 2022 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1656081464;
	bh=hwkWxLhPvE3I9Sum64sHBLZwcLuYQFUFCNO9IhEHEpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sm3+TvzJ17HUWUEtgIhF2H8go4OXYUIVdKKvRuz4TGlSur5GU+FhNSln64m6C4n/Y
	 7UBk3N7GkM7SJQAlk/G9D6PHc9Ew5V+VBKFZaNf1PGR69I6wpKb7ELSPXWc25APNP7
	 vmguhzWft30H5nOCZ1kgf7EBuYVESnh4aJG3J8HY=
Date: Fri, 24 Jun 2022 16:37:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, acc@openeuler.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/2] fix uacce concurrency issue of uacce_remove
Message-ID: <YrXMNePEO+6ZDysd@kroah.com>
References: <20220624142122.30528-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624142122.30528-1-zhangfei.gao@linaro.org>

On Fri, Jun 24, 2022 at 10:21:20PM +0800, Zhangfei Gao wrote:
> When uacce is working, uacce parent module can be rmmod, parent
> device can also be removed anytime, which may cause concurrency issues.
> Here solve the concurrency issue.
> 
> Jean-Philippe Brucker (1):
>   uacce: Handle parent device removal
> 
> Zhangfei Gao (1):
>   uacce: Handle parent driver module removal
> 
>  drivers/misc/uacce/uacce.c | 135 ++++++++++++++++++++++++-------------
>  include/linux/uacce.h      |   6 +-
>  2 files changed, 92 insertions(+), 49 deletions(-)
> 
> -- 
> 2.36.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
