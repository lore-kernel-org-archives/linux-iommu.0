From: Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
Subject: AMD IOMMU: Please support Marvell 88SE91xx SATA Controllers
Date: Mon, 20 May 2013 23:21:52 +0200
Message-ID: <519A93F0.8070606@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

I do own a Gigabyte GA-990FXA-UD5 main-board which comes with a
Marvell 88SE9172 SATA Controller [1b4b:9172].

Unfortunately, this controller only works when disabling IOMMU in the
BIOS settings, which is a pity.

Andrew Cooks did a patch for Intel IOMMU
[http://marc.info/?l=linux-kernel&m=136271019511044&w=4 , resp.
  http://lists.linuxfoundation.org/pipermail/iommu/2013-April/005462.html ],
which seems to work fine.


Is anybody working on this issue for the AMD part? I would be very grateful if such
support could be added to the linux kernel. I would be prepared to
test patches, if needed.

Thanks a lot,
Manfred
