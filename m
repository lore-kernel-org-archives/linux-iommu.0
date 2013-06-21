From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] iommu/amd: IOMMU Error Reporting/Handling/Filtering
Date: Fri, 21 Jun 2013 18:24:55 +0200
Message-ID: <20130621162455.GN11309@8bytes.org>
References: <1369250155-12226-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130621151459.GK11309@8bytes.org>
	<20130621155933.GA24385@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130621155933.GA24385-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 21, 2013 at 05:59:33PM +0200, Borislav Petkov wrote:
> On Fri, Jun 21, 2013 at 05:15:00PM +0200, Joerg Roedel wrote:
> > Instead of extending this bad scaling dmesg error-reporting mechanism,
> > I would very much like to see an integration of IOMMU error handling
> > into the EDAC framework.
> 
> Wouldn't just adding a tracepoint and collecting the logs in debugfs be
> enough? This would at least avoid spamming syslog with the messages.

I would rather not create another user-space interface for this which we
then have to keep forever because someone started using it. What we need
is a well defined mechanism to report these kernel metrics to userspace
which can then do with it whatever it wants. I think EDAC can provide
that interface.


	Joerg
