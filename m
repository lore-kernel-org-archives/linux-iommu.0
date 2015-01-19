From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Generic IOMMU page table framework
Date: Mon, 19 Jan 2015 15:56:42 +0200
Message-ID: <2897578.zknPhjxUSB@avalon>
References: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
	<20150119130940.GJ6343@8bytes.org> <20150119131843.GJ32131@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150119131843.GJ32131-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 19 January 2015 13:18:43 Will Deacon wrote:
> On Mon, Jan 19, 2015 at 01:09:41PM +0000, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> > On Fri, Jan 16, 2015 at 02:01:31PM +0000, Will Deacon wrote:
> >> I've not received any feedback on this revision of the series, but it's
> >> working well for me and Laurent showed that it works with his IOMMU too.
> >> 
> >> Joerg -- can I include this in my pull request for 3.20, or is there
> >> anything further you'd like me to address? The code is completely
> >> self-contained, so I wouldn't expect any impact on IOMMU drivers that
> >> don't explicitly use the new page table API.
> > 
> > The patch-set looks good to me. But with code generification in general,
> > what are the plans for other arm iommu drivers to adopt this?
> 
> I think Laurent was going to make use of it and I'm working on a driver
> that will use it too.
> 
> Laurent -- you had patches ready to go for v1, right?

Yes, and I've rebased them (or actually it, it's a single patch) on v2. I 
haven't had time to test the result yet, I'll try to do so later tonight or 
tomorrow.

-- 
Regards,

Laurent Pinchart
