From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu/vt-d: Flush old iommu caches for kdump when the
 device gets context mapped
Date: Tue, 6 Dec 2016 17:03:46 +0100
Message-ID: <20161206160346.GB27203@8bytes.org>
References: <1480939747-31916-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480939747-31916-1-git-send-email-xlpang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xunlei Pang <xlpang@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@gmail.com>, Joseph Szczypek <jszczype@redhat.com>, Don Brace <don.brace@microsemi.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 05, 2016 at 08:09:07PM +0800, Xunlei Pang wrote:
>  drivers/iommu/intel-iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied, thanks.
