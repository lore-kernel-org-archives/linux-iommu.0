From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19-rc5: Missing iommu fix
Date: Wed, 26 Sep 2018 21:59:17 +0200
Message-ID: <20180926195917.GB20689@kroah.com>
References: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 24, 2018 at 11:33:39AM +0200, Sedat Dilek wrote:
> Hi Greg,
> 
> thanks and congrats for this release.
> 
> Me and several other people have an issue with "intel_iommu=on" (see
> [1]) and a patch is pending in [2].
> Unfortunately, it is not in linux-iommu Git.
> Hope this will soon happen.
> 
> Just want to inform you and let people know if they have a similiar problem.

Is this all now merged properly?

thanks,

greg k-h
