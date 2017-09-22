From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/of: Remove PCI host bridge node check
Date: Fri, 22 Sep 2017 12:06:19 +0200
Message-ID: <20170922100619.GK8398@8bytes.org>
References: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
	<56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
	<20170922085618.GI8398@8bytes.org>
	<49550b7b-b5bc-6687-dc5d-3a71605389ca@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49550b7b-b5bc-6687-dc5d-3a71605389ca-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 22, 2017 at 10:51:30AM +0100, Robin Murphy wrote:
> 
> Fixes: d87beb749281 ("iommu/of: Handle PCI aliases properly")
> 
> The check itself originally dates back to b996444cf35e ("iommu/of:
> Handle iommu-map property for PCI") but it's really not worth
> backporting past the above refactoring - it's only with da4b02750a9f
> ("iommu/of: Fix of_iommu_configure() for disabled IOMMUs") in 4.14-rc1
> that it started to have noticeable ill effects.

Thanks, applied to iommu/fixes.
