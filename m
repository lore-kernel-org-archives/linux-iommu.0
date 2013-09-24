From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/7] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
Date: Tue, 24 Sep 2013 16:19:46 +0100
Message-ID: <20130924151946.GA20774@mudshark.cambridge.arm.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-2-git-send-email-andreas.herrmann@calxeda.com>
 <20130924151430.GT4845@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130924151430.GT4845@alberich>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Herrmann <andreas.herrmann@calxeda.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 24, 2013 at 04:14:30PM +0100, Andreas Herrmann wrote:
> iommu/arm-smmu: Remove bogus semicolon from if conditions
> 
> Those prevented proper registration of arm_smmu_ops.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Will,
> 
> It seems that I've managed to exclude the very first patch of the
> series. Here it is.

No worries; I already have a fix for this and Joerg pulled it today.

Will
