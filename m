From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu: Allow default domain type to be set on the
	kernel command line
Date: Thu, 26 Jan 2017 17:48:17 +0000
Message-ID: <20170126174816.GO14167@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<1484849955-1871-6-git-send-email-will.deacon@arm.com>
	<20170126171555.GD27598@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170126171555.GD27598-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2017 at 06:15:55PM +0100, Joerg Roedel wrote:
> On Thu, Jan 19, 2017 at 06:19:15PM +0000, Will Deacon wrote:
> > Rather than modify each IOMMU driver to provide different semantics for
> > DMA domains, instead we introduce a command line parameter that can be
> > used to change the type of the default domain. Passthrough can then be
> > specified using "iommu.default_domain=identity" on the kernel command
> > line.
> 
> I like the general idea of this, but the above is a terrible name for a
> kernel commandline-parameter. The x86 iommus support iommu=pt which is
> pretty much the same as this patch does.

Happy to bikeshed the name ;)

> How about something like "iommu.passthrough=0/1"? And please add the
> parameter to the kernel documentation too.

Sure, if you think that the identity domain is the only thing we'll ever
want to set (so far, it's the only thing people have asked me for).

Will
