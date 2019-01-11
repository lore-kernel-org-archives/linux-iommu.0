From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/of: Fix probe-deferral
Date: Fri, 11 Jan 2019 12:28:49 +0100
Message-ID: <20190111112849.y2gfhpw2lk3fjojb@8bytes.org>
References: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 07, 2019 at 05:04:50PM +0000, Robin Murphy wrote:
> Whilst iommu_probe_device() does check for non-NULL ops as the previous
> code did, it does not do so in the same order relative to the other
> checks, and as a result means that -EPROBE_DEFER returned by of_xlate()
> (plus any real error condition too) gets overwritten with -EINVAL and
> leads to various misbehaviour.
> 
> Reinstate the original logic, but without implicitly relying on ops
> being set to infer !err as the initial condition (now that the validity
> of ops for its own sake is checked elsewhere).
> 
> Fixes: 641fb0efbff0 ("iommu/of: Don't call iommu_ops->add_device directly")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied to iommu/fixes, thanks.
