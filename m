From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 15:25:21 +0100
Message-ID: <20120124142521.GE6269@8bytes.org>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com>
	<1325747509-29665-3-git-send-email-hdoyu@nvidia.com>
	<20120123154310.GC6269@8bytes.org>
	<20120124.154121.1062920821192552748.hdoyu@nvidia.com>
	<20120124134601.GT27414@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120124134601.GT27414-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 24, 2012 at 03:46:01PM +0200, Felipe Balbi wrote:
> On Tue, Jan 24, 2012 at 02:41:21PM +0100, Hiroshi Doyu wrote:
> > Actually I really like the concept of this "domain" now, which hides
> > the H/W hierarchy from users.
> > 
> > But in Tegra SMMU/GART case, there's a single one IOMMU device in the
> > system. Keeping a iommu device list in a domain and iterating iommu
> > device list in each iommu_ops seem to be so nice, but I'm afraid that
> > this may be a bit too much when one already knows that there's only
> > one IOMMU device in the system.
> >
> > If there's no actual problem for 1-1 mapping between IOMMU H/Ws and
> > domains, I think that it may not so bad to keep the original code(1-1)
> > for GART and SMMU. What do you think?
> 
> I think it boils down to "extensability". If you can truly/fully
> guarantee that there will *always* be a single IOMMU on all upcoming
> Tegras, then it's really overkill.
> 
> But if there's even a remote possibility of the HW being changed and you
> end up with more IOMMUs, things start to feel necessary for the sake of
> making it easy to extend.

Right. But I am fine with the logic as-is when there is only one SMMU in
the system. But please also change the IOMMU driver so that it really
only initializes a single SMMU. When boards pop up with more than one
you we notice that assumption in the code again and are reminded to
change it.


	Joerg
