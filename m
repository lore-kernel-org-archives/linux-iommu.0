From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/3] intel-iommu: generalize __mapping_notify_one()
Date: Thu, 3 May 2018 15:14:24 +0200
Message-ID: <20180503131424.jsn4qvfuwur7adcb@8bytes.org>
References: <20180418083953.21492-1-peterx@redhat.com>
 <20180418083953.21492-3-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418083953.21492-3-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Alexander Witte <alexander.witte@baicanada.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 18, 2018 at 04:39:52PM +0800, Peter Xu wrote:
> Generalize this new helper to notify one newly created mapping on one
> single IOMMU.  We can further leverage this helper in the next patch.

You introduce the function, you do not generalize it. Please fix that in
the subject and description.

Also, please drop patch 1, I don't like this pr_debug stuff in the
code. And please also fix the subject line in general to match the form:

	iommu/vt-d: _I_ntroduce __mapping_notify_one()

When that is done, please re-send.

Thanks,

	Joerg
