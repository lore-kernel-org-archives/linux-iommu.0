From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4] iommu/iova: Optimise attempts to allocate iova from
 32bit address range
Date: Tue, 25 Sep 2018 10:18:48 +0200
Message-ID: <20180925081848.fh32go4nwvtmfjn2@8bytes.org>
References: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com, gklkml16@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 05, 2018 at 09:57:36AM +0530, Ganapatrao Kulkarni wrote:
>  drivers/iommu/iova.c | 22 +++++++++++++++-------
>  include/linux/iova.h |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)

Applied, thanks.
