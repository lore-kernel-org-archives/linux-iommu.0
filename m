From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2 v2] Fix MAX_PHANDLE_ARGS limitations
Date: Thu, 16 Jul 2015 10:30:42 +0200
Message-ID: <1437035444-13867-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Hi,

here is the second version of my patches to fix the
MAX_PHANDLE_ARGS limitation for the arm-smmu driver. On my
AMD Seattle system the max value of 16 is not enough to
initialize the SMMU, as the device tree node has an entry
with 25 phandle args (possible are up to 128). The result is
a WARNING and incorrect SMMU initialization.

On the other side MAX_PHANDLE_ARGS can't grow indefinitly,
as it causes 'struct of_phandle_args' to get bigger. This
struct is often allocated on-stack and should be small by
default.

So these patches introduce a way to make 'struct
of_phandle_args' bigger only when needed and change the
ARM-SMMU driver to make use of it.

The patches have been tested on my AMD Seattle system.

Please review.

Thanks,

	Joerg

Changes to v1:

	* Rebased to v4.2-rc2
	* Fixed leak in patch 2, as pointed out by Will
	  Deacon

Joerg Roedel (2):
  of: base: Allow more args than MAX_PHANDLE_ARGS if required
  arm/smmu: Make use of of_parse_phandle_with_var_args

 drivers/iommu/arm-smmu.c | 23 ++++++++++++++++-------
 drivers/of/base.c        | 43 ++++++++++++++++++++++++++++++++++++-------
 include/linux/of.h       |  7 +++++++
 3 files changed, 59 insertions(+), 14 deletions(-)

-- 
1.8.4.5
