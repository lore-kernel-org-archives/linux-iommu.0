From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: RFC: additional domain attributes specific to PAMU
Date: Tue, 5 Feb 2013 11:35:34 +0100
Message-ID: <20130205103533.GQ25591@8bytes.org>
References: <CALRxmdChbSk1gLXc2pqVd0GPdM09SofyjA5L_KuvSn4SQZJoXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALRxmdChbSk1gLXc2pqVd0GPdM09SofyjA5L_KuvSn4SQZJoXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On Mon, Feb 04, 2013 at 09:37:20PM -0600, Stuart Yoder wrote:
> +       DOMAIN_ATTR_ENABLE,
> +       DOMAIN_ATTR_FSL_PAMUV1,
> Instead of advertising those constraints somehow, it seem easier just
> to advertise that this IOMMU is a PAMU v1.  The attribute would be
> read only and would be a boolean--  if the attribute is present then
> it's a PAMU v1.

> [...]

> Wanted to get your thoughts on that.

Sounds reasonable. Just put PAMU into the name of the attributes to make
clear these attributes are specific to your implementation and implement
the attributes in the PAMU specific get/set_attr call-backs. This is
particularily true for DOMAIN_ATTR_ENABLE (or better
DOMAIN_ATTR_PAMU_ENABLE). We can also go with DOMAIN_ATTR_FSL_PAMUV1 for
now, but a more generic way of determining the IOMMU type might make
sense. But this can be changed later.

Regards,

	Joerg
