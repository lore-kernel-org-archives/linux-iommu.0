From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] ARM SMMU fixes
Date: Thu, 03 Apr 2014 01:52:55 +0200
Message-ID: <2243447.NTvYmPQWSB@avalon>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Friday 28 February 2014 16:37:08 Laurent Pinchart wrote:
> Hello Will,
> 
> I've studied your arm-smmu driver as a base to write a Renesas IOMMU driver
> and found two small issues. Here are patches to fix them. Please bear with
> me if my understanding was incorrect and the patches wrong :-)
> 
> Laurent Pinchart (2):
>   iommu/arm-smmu: Replace list walk with platform driver data
>   iommu/arm-smmu: Return 0 on unmap failure
> 
>  drivers/iommu/arm-smmu.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Do you plan to take these patches (or at least patch 2/2) in your tree ? I can 
send a pull request to Joerg if you give me your acked-by.

-- 
Regards,

Laurent Pinchart
