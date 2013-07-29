From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
Date: Mon, 29 Jul 2013 12:13:44 +0200
Message-ID: <20130729.131344.1221933042559369096.hdoyu@nvidia.com>
References: <1373021097-32420-2-git-send-email-hdoyu@nvidia.com><51E5CFBF.5080407@wwwdotorg.org><20130716231629.GA12189@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130716231629.GA12189-RcKxWJ4Cfj3FNiLNb7+IINdj8bHVeoWogfoxzgwHRXE@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:16:30 +0200:

> * PGP Signed by an unknown key
> 
> On Tue, Jul 16, 2013 at 04:57:03PM -0600, Stephen Warren wrote:
> > On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > > To prevent of_platform_populate() from trying to populate duplicate
> > > devices if a device has been already populated.
> > 
> > You need to send drivers/of patches to the DT maintainer and
> > devicetree-discuss mailing list.
> > 
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > > Need to take care of early_platform_devices, or alternative solution.
> > 
> > I assume that's a TODO item... Are you planning on fleshing out this
> > patch to address that issue?
>
> There was some more discussion about it, which can be found in the
> following thread:
> 
> 	https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036934.html
> 
> That's one of the last messages and it should have most of the
> background. If not you may have to walk up the thread for more context.
> In a nutshell I raised the question as to why we can't simply call
> of_platform_populate() earlier and side-step all the workarounds that
> have found their way into the kernel to side-step the issue of their not
> being a struct device associated with the struct device_node.

This is the thread which Lorenzo started originally. He may have some
plan to implement/proceed with this, Lorenzo?
