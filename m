From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: unwrap __get_valid_domain_for_dev()
Date: Tue, 30 May 2017 11:42:21 +0200
Message-ID: <20170530094221.GF2818@8bytes.org>
References: <1495448931-20382-1-git-send-email-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495448931-20382-1-git-send-email-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 22, 2017 at 06:28:51PM +0800, Peter Xu wrote:
> We do find_domain() in __get_valid_domain_for_dev(), while we do the
> same thing in get_valid_domain_for_dev().  No need to do it twice.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)


Applied, thanks.
