From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 0/2] of: Implement iterator for phandles
Date: Wed, 16 Mar 2016 17:42:05 +0100
Message-ID: <1458146527-1133-1-git-send-email-joro@8bytes.org>
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
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is an implementation of the iterator over phandles
concept which Rob Herring suggested to me some time ago. My
approach is a little bit different from what the diff showed
back then, but it gets rid of the allocation and 'struct
'struct of_phandle_args' misuse.

I also converted the arm-smmu driver to make use of the
iterator. The resulting kernel boots on my AMD Seattle
system and fixes the warning triggered there.

There is still some work to to on this change, but it would
be cool to get some early feedback on the code and the
direction it takes. Here is also my todo-list for this
before next submission:

TODO:

* Reorder members of 'struct of_phandle_iterator' and do
  some renaming and documentation of them.

* Split up first patch to make it easier to review and
  bisect.

* Re-add and update some comments which got lost during the
  conversion.

Any feedback is appreciated.

Thanks,

	Joerg

Joerg Roedel (2):
  of: Implement iterator for phandles
  iommu/arm-smmu: Make use of phandle iterators in device-tree parsing

 drivers/iommu/arm-smmu.c |  27 ++++--
 drivers/of/base.c        | 219 +++++++++++++++++++++++++++--------------------
 include/linux/of.h       |  95 ++++++++++++++++++++
 3 files changed, 241 insertions(+), 100 deletions(-)

-- 
1.9.1
